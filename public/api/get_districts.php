<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../src/Database.php';

initApi(['methods' => ['GET'], 'method' => 'GET']);

try {
    $districts = Database::query("SELECT id, name FROM districts ORDER BY name");

    $districtMap = [];
    foreach ($districts as $district) {
        $districtMap[$district['id']] = $district['name'];
    }

    jsonResponse(['districts' => $districtMap]);
} catch (Exception $e) {
    error_log("Error in get_districts: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
?>