<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../src/Database.php';

initApi(['methods' => ['GET'], 'method' => 'GET']);

$districtId = $_GET['district_id'] ?? null;
if (!$districtId || !is_numeric($districtId)) {
    jsonResponse(['error' => 'district_id required and must be integer'], 400);
}

$pageRaw = $_GET['page'] ?? '1';
$pageSizeRaw = $_GET['page_size'] ?? '10';
if (!is_numeric($pageRaw) || (int)$pageRaw < 1) {
    jsonResponse(['error' => 'page must be a positive integer'], 400);
}
if (!is_numeric($pageSizeRaw) || (int)$pageSizeRaw < 1) {
    jsonResponse(['error' => 'page_size must be a positive integer'], 400);
}

$page = (int)$pageRaw;
$pageSize = min(10, (int)$pageSizeRaw);
$offset = ($page - 1) * $pageSize;

$where = ['i.district_id = ?'];
$params = [(int)$districtId];
$needsDirectorJoin = false;

if (!empty($_GET['type']) && is_array($_GET['type'])) {
    $typesList = array_values(array_filter(array_map('trim', $_GET['type']), static fn($v) => $v !== ''));
    if (!empty($typesList)) {
        $placeholders = implode(',', array_fill(0, count($typesList), '?'));
        $where[] = "i.type_code IN ($placeholders)";
        $params = array_merge($params, $typesList);
    }
}

if (!empty($_GET['condition']) && is_array($_GET['condition'])) {
    $conditionsList = array_values(array_filter(array_map('trim', $_GET['condition']), static fn($v) => $v !== ''));
    if (!empty($conditionsList)) {
        $placeholders = implode(',', array_fill(0, count($conditionsList), '?'));
        $where[] = "EXISTS (
            SELECT 1 FROM institution_conditions ic2
            JOIN condition_types ct2 ON ic2.condition_code = ct2.code
            WHERE ic2.institution_id = i.id AND ct2.code IN ($placeholders)
        )";
        $params = array_merge($params, $conditionsList);
    }
}

if (!empty($_GET['aoop'])) {
    $where[] = 'EXISTS (SELECT 1 FROM aoop_programs ap WHERE ap.institution_id = i.id)';
}

if (!empty($_GET['age']) && is_array($_GET['age'])) {
    $ageFilters = [];
    foreach ($_GET['age'] as $age) {
        $age = trim((string)$age);
        if ($age === '1.5-3') {
            $ageFilters[] = '(i.range_min IS NOT NULL AND i.range_max IS NOT NULL AND i.range_min <= 3 AND i.range_max >= 1.5)';
        } elseif ($age === '3-5') {
            $ageFilters[] = '(i.range_min IS NOT NULL AND i.range_max IS NOT NULL AND i.range_min <= 5 AND i.range_max >= 3)';
        } elseif ($age === '5-7') {
            $ageFilters[] = '(i.range_min IS NOT NULL AND i.range_max IS NOT NULL AND i.range_min <= 7 AND i.range_max >= 5)';
        } elseif ($age === '7+') {
            $ageFilters[] = '(i.range_max IS NOT NULL AND i.range_max >= 7)';
        } elseif ($age === '3-4') {
            $ageFilters[] = '(i.range_min IS NOT NULL AND i.range_max IS NOT NULL AND i.range_min <= 4 AND i.range_max >= 3)';
        } elseif ($age === '5-6') {
            $ageFilters[] = '(i.range_min IS NOT NULL AND i.range_max IS NOT NULL AND i.range_min <= 6 AND i.range_max >= 5)';
        }
    }
    if ($ageFilters) {
        $where[] = '(' . implode(' OR ', $ageFilters) . ')';
    }
}

$searchTerm = isset($_GET['q']) ? trim((string)$_GET['q']) : '';
if ($searchTerm !== '') {
    $needsDirectorJoin = true;
    $like = '%' . $searchTerm . '%';
    $searchParts = [
        'i.name ILIKE ?',
        'COALESCE(i.description, \'\') ILIKE ?',
        'COALESCE(i.website, \'\') ILIKE ?',
        'COALESCE(d.full_name, \'\') ILIKE ?',
    ];
    $searchParams = [$like, $like, $like, $like];

    if (preg_match('/\d+/', $searchTerm, $numMatch)) {
        $searchParts[] = "(substring(i.name from '\\d+') = ?)";
        $searchParams[] = $numMatch[0];
    }

    $synonyms = [
        'preschool' => ['детсад', 'детскийсад', 'садик', 'дс', 'сад'],
        'school' => ['школа', 'шк', 'сош', 'лицей', 'гимназия'],
        'school_internat' => ['интернат', 'школаинтернат'],
        'spo' => ['спо', 'техникум', 'колледж', 'училище'],
        'vo' => ['во', 'вуз', 'университет', 'институт', 'академия'],
    ];
    $normalizedQ = mb_strtolower(preg_replace('/\s+/u', '', $searchTerm), 'UTF-8');
    $matchedTypes = [];
    foreach ($synonyms as $type => $words) {
        foreach ($words as $word) {
            if ($normalizedQ !== '' && mb_strpos($normalizedQ, $word) !== false) {
                $matchedTypes[$type] = true;
                break;
            }
        }
    }
    if (!empty($matchedTypes)) {
        $typeCodes = array_keys($matchedTypes);
        $placeholders = implode(',', array_fill(0, count($typeCodes), '?'));
        if (preg_match('/\d+/', $searchTerm, $numMatch)) {
            $searchParts[] = "(i.type_code IN ($placeholders) AND substring(i.name from '\\d+') = ?)";
            $searchParams = array_merge($searchParams, $typeCodes, [$numMatch[0]]);
        } else {
            $searchParts[] = "i.type_code IN ($placeholders)";
            $searchParams = array_merge($searchParams, $typeCodes);
        }
    }

    $where[] = '(' . implode(' OR ', $searchParts) . ')';
    $params = array_merge($params, $searchParams);
}

$whereSql = implode(' AND ', $where);
$fromSql = 'FROM institutions i';
if ($needsDirectorJoin) {
    $fromSql .= ' LEFT JOIN directors d ON i.director_id = d.id';
}

try {
    $total = (int)Database::fetchOne(
        "SELECT COUNT(*) $fromSql WHERE $whereSql",
        $params
    );

    $idRows = Database::query(
        "SELECT i.id $fromSql WHERE $whereSql ORDER BY i.name ASC LIMIT ? OFFSET ?",
        array_merge($params, [$pageSize, $offset])
    );
    $ids = array_map(static fn($row) => (int)$row['id'], $idRows);

    if (empty($ids)) {
        jsonResponse([
            'institutions' => [],
            'total' => $total,
            'page' => $page,
            'page_size' => $pageSize,
        ]);
    }

    $idPlaceholders = implode(',', array_fill(0, count($ids), '?'));
    $detailSql = "
        SELECT
            i.id, i.name, i.address, i.description, i.range_min, i.range_max, i.website, i.aoop_url,
            d.full_name as director_name, d.phone as director_phone, d.email as director_email,
            d.id as director_id,
            it.code as type_code, it.name_ru as type_name,
            array_agg(DISTINCT ct.code) FILTER (WHERE ct.code IS NOT NULL) as condition_codes,
            array_agg(DISTINCT at.code) FILTER (WHERE at.code IS NOT NULL) as admission_codes,
            json_agg(json_build_object('id', ap.id, 'name', ap.name, 'url', ap.url)) FILTER (WHERE ap.name IS NOT NULL) as aoop_programs
        FROM institutions i
        LEFT JOIN directors d ON i.director_id = d.id
        LEFT JOIN institution_types it ON i.type_code = it.code
        LEFT JOIN institution_conditions ic ON i.id = ic.institution_id
        LEFT JOIN condition_types ct ON ic.condition_code = ct.code
        LEFT JOIN institution_admission ia ON i.id = ia.institution_id
        LEFT JOIN admission_types at ON ia.admission_code = at.code
        LEFT JOIN aoop_programs ap ON i.id = ap.institution_id
        WHERE i.id IN ($idPlaceholders)
        GROUP BY i.id, d.id, d.full_name, d.phone, d.email, it.code, it.name_ru
    ";

    $institutions = Database::query($detailSql, $ids);

    $byId = [];
    foreach ($institutions as $inst) {
        $conditionCodes = $inst['condition_codes'] ? trim($inst['condition_codes'], '{}') : '';
        $inst['conditions'] = $conditionCodes ? explode(',', $conditionCodes) : [];

        $admissionCodes = $inst['admission_codes'] ? trim($inst['admission_codes'], '{}') : '';
        $inst['conditionsAdmission'] = $admissionCodes ? explode(',', $admissionCodes) : [];

        $aoopRaw = $inst['aoop_programs'] ? json_decode($inst['aoop_programs'], true) : [];
        $inst['aoop_programs'] = [];
        if ($aoopRaw) {
            $seenIds = [];
            foreach ($aoopRaw as $prog) {
                if (!in_array($prog['id'], $seenIds, true)) {
                    $inst['aoop_programs'][] = $prog;
                    $seenIds[] = $prog['id'];
                }
            }
        }

        $inst['director'] = [
            'id' => $inst['director_id'] ?? null,
            'name' => $inst['director_name'] ?? '',
            'phone' => formatPhoneForDisplay($inst['director_phone'] ?? '') ?? '',
            'email' => normalizeEmailForDisplay($inst['director_email'] ?? '') ?? ''
        ];
        $inst['type'] = $inst['type_code'];
        $inst['district_id'] = (int)$districtId;
        $inst['address'] = isset($inst['address']) ? trim($inst['address']) : null;
        unset(
            $inst['condition_codes'],
            $inst['admission_codes'],
            $inst['type_name'],
            $inst['type_code'],
            $inst['director_name'],
            $inst['director_phone'],
            $inst['director_email'],
            $inst['director_id']
        );
        $byId[(int)$inst['id']] = $inst;
    }

    $ordered = [];
    foreach ($ids as $id) {
        if (isset($byId[$id])) {
            $ordered[] = $byId[$id];
        }
    }

    jsonResponse([
        'institutions' => $ordered,
        'total' => $total,
        'page' => $page,
        'page_size' => $pageSize,
    ]);
} catch (Exception $e) {
    error_log('Error in get_institutions: ' . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
