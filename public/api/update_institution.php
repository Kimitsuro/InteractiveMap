<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../config/validation.php';
require_once __DIR__ . '/../../src/Database.php';

initApi(['methods' => ['POST'], 'method' => 'POST', 'admin' => true, 'csrf' => true, 'credentials' => true]);

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    jsonResponse(['error' => 'Invalid JSON'], 400);
}

$data = validateInstitutionPayload($input, true);
$instId = $data['id'];

try {
    $pdo = Database::getInstance();

    $oldSql = "
        SELECT
            i.*, i.address, d.full_name as director_name, d.phone as director_phone, d.email as director_email,
            array_agg(DISTINCT ct.code) FILTER (WHERE ct.code IS NOT NULL) as condition_codes,
            array_agg(DISTINCT at.code) FILTER (WHERE at.code IS NOT NULL) as admission_codes,
            json_agg(json_build_object('id', ap.id, 'name', ap.name)) FILTER (WHERE ap.name IS NOT NULL) as aoop_programs
        FROM institutions i
        LEFT JOIN directors d ON i.director_id = d.id
        LEFT JOIN institution_conditions ic ON i.id = ic.institution_id
        LEFT JOIN condition_types ct ON ic.condition_code = ct.code
        LEFT JOIN institution_admission ia ON i.id = ia.institution_id
        LEFT JOIN admission_types at ON ia.admission_code = at.code
        LEFT JOIN aoop_programs ap ON i.id = ap.institution_id
        WHERE i.id = ?
        GROUP BY i.id, d.id, d.full_name, d.phone, d.email
    ";
    $oldData = Database::query($oldSql, [$instId]);

    if (empty($oldData)) {
        jsonResponse(['error' => 'Institution not found'], 404);
    }

    $oldInst = $oldData[0];
    $oldJson = [
        'name' => $oldInst['name'],
        'address' => $oldInst['address'] ?? null,
        'district_id' => (int) $oldInst['district_id'],
        'type' => $oldInst['type_code'],
        'director' => [
            'name' => $oldInst['director_name'] ?? '',
            'phone' => $oldInst['director_phone'] ?? '',
            'email' => $oldInst['director_email'] ?? '',
        ],
        'description' => $oldInst['description'],
        'range' => [
            'min' => $oldInst['range_min'],
            'max' => $oldInst['range_max'],
        ],
        'website' => $oldInst['website'],
        'aoop_url' => $oldInst['aoop_url'],
        'conditions' => $oldInst['condition_codes'] ? explode(',', trim($oldInst['condition_codes'], '{}')) : [],
        'conditionsAdmission' => $oldInst['admission_codes'] ? explode(',', trim($oldInst['admission_codes'], '{}')) : [],
        'aoop_programs' => $oldInst['aoop_programs'] ? json_decode($oldInst['aoop_programs'], true) : [],
    ];

    $directorId = null;
    if (!empty($data['director']['name'])) {
        if (!empty($data['director']['id'])) {
            $directorSql = "UPDATE directors SET full_name = ?, phone = ?, email = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ? RETURNING id";
            Database::execute($directorSql, [
                $data['director']['name'],
                $data['director']['phone'],
                $data['director']['email'],
                $data['director']['id'],
            ]);
            $directorId = $data['director']['id'];
        } else {
            $directorId = Database::fetchOne("INSERT INTO directors (full_name, phone, email) VALUES (?, ?, ?) RETURNING id", [
                $data['director']['name'],
                $data['director']['phone'],
                $data['director']['email'],
            ]);
        }
    }

    $updateSql = "
        UPDATE institutions
        SET name = ?, district_id = ?, type_code = ?, director_id = ?, description = ?,
        range_min = ?, range_max = ?, website = ?, aoop_url = ?, address = ?, updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
    ";
    Database::execute($updateSql, [
        $data['name'],
        $data['district_id'],
        $data['type'],
        $directorId,
        $data['description'],
        $data['range']['min'],
        $data['range']['max'],
        $data['website'],
        $data['aoop_url'],
        $data['address'],
        $instId,
    ]);

    Database::execute("DELETE FROM institution_conditions WHERE institution_id = ?", [$instId]);
    Database::execute("DELETE FROM institution_admission WHERE institution_id = ?", [$instId]);
    Database::execute("DELETE FROM aoop_programs WHERE institution_id = ?", [$instId]);

    if (!empty($data['conditions'])) {
        $condSql = "INSERT INTO institution_conditions (institution_id, condition_code) VALUES (?, ?) ON CONFLICT DO NOTHING";
        foreach ($data['conditions'] as $cond) {
            Database::execute($condSql, [$instId, $cond]);
        }
    }

    if (!empty($data['conditionsAdmission'])) {
        $admSql = "INSERT INTO institution_admission (institution_id, admission_code) VALUES (?, ?) ON CONFLICT DO NOTHING";
        foreach ($data['conditionsAdmission'] as $adm) {
            Database::execute($admSql, [$instId, $adm]);
        }
    }

    if (!empty($data['aoop_programs'])) {
        $aoopSql = "INSERT INTO aoop_programs (institution_id, name, url) VALUES (?, ?, ?) ON CONFLICT DO NOTHING";
        foreach ($data['aoop_programs'] as $prog) {
            Database::execute($aoopSql, [$instId, $prog['name'], $prog['url']]);
        }
    }

    $logSql = "INSERT INTO action_log (administrator_id, action, entity, record_id, old_data, new_data) VALUES (?, 'UPDATE', 'institutions', ?, ?::jsonb, ?::jsonb)";
    Database::execute($logSql, [$_SESSION['admin_id'], $instId, json_encode($oldJson), json_encode($data)]);

    jsonResponse(['success' => true]);
} catch (InvalidArgumentException $e) {
    jsonResponse(['error' => $e->getMessage()], 400);
} catch (Exception $e) {
    error_log("Error in update_institution: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
?>
