<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../config/validation.php';
require_once __DIR__ . '/../../src/Database.php';

initApi(['methods' => ['POST'], 'method' => 'POST', 'admin' => true, 'credentials' => true]);

$input = json_decode(file_get_contents('php://input'), true);
if (!$input) {
    jsonResponse(['error' => 'Invalid JSON'], 400);
}

$data = validateInstitutionPayload($input, false);

$pdo = Database::getInstance();
try {
    $pdo->beginTransaction();

    $directorId = null;
    if (!empty($data['director']['name'])) {
        // На создании не принимаем чужой director.id — всегда новый директор
        $directorId = Database::fetchOne(
            "INSERT INTO directors (full_name, phone, email) VALUES (?, ?, ?) RETURNING id",
            [
                $data['director']['name'],
                $data['director']['phone'],
                $data['director']['email'],
            ]
        );
    }

    $instId = Database::fetchOne(
        "INSERT INTO institutions (name, district_id, type_code, director_id, description, range_min, range_max, website, aoop_url, address)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id",
        [
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
        ]
    );

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
        $aoopSql = "INSERT INTO aoop_programs (institution_id, name, url) VALUES (?, ?, ?)";
        foreach ($data['aoop_programs'] as $prog) {
            Database::execute($aoopSql, [$instId, $prog['name'], $prog['url'] ?? null]);
        }
    }

    Database::execute(
        "INSERT INTO action_log (administrator_id, action, entity, record_id, new_data) VALUES (?, 'CREATE', 'institutions', ?, ?::jsonb)",
        [$_SESSION['admin_id'], $instId, json_encode($data)]
    );

    $pdo->commit();
    jsonResponse(['id' => $instId], 201);
} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    error_log("Error in create_institution: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
