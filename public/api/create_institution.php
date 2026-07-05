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

$data = validateInstitutionPayload($input, false);

try {
    $pdo = Database::getInstance();
    $directorId = null;

    if (!empty($data['director']['name'])) {
        if (!empty($data['director']['id'])) {
            $directorId = $data['director']['id'];
        } else {
            $directorSql = "INSERT INTO directors (full_name, phone, email) VALUES (?, ?, ?) RETURNING id";
            $directorId = Database::fetchOne($directorSql, [
                $data['director']['name'],
                $data['director']['phone'],
                $data['director']['email'],
            ]);
        }
    }

    $instSql = "
        INSERT INTO institutions (name, district_id, type_code, director_id, description, range_min, range_max, website, aoop_url, address)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        RETURNING id
    ";
    $instId = Database::fetchOne($instSql, [
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
    ]);

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

    $logSql = "INSERT INTO action_log (administrator_id, action, entity, record_id, new_data) VALUES (?, 'CREATE', 'institutions', ?, ?::jsonb)";
    Database::execute($logSql, [$_SESSION['admin_id'], $instId, json_encode($data)]);

    jsonResponse(['id' => $instId], 201);
} catch (InvalidArgumentException $e) {
    jsonResponse(['error' => $e->getMessage()], 400);
} catch (Exception $e) {
    error_log("Error in create_institution: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
?>
