<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../src/Database.php';

initApi(['methods' => ['GET'], 'method' => 'GET']);

$district_id = isset($_GET['district_id']) ? intval($_GET['district_id']) : 0;
if ($district_id < 1) {
    jsonResponse(['error' => 'district_id required'], 400);
}

try {
    $links = Database::query(
        "SELECT linksto, linktoinstitution FROM links WHERE district_id = :did ORDER BY id",
        ['did' => $district_id]
    );
    jsonResponse(['links' => $links]);
} catch (Exception $e) {
    error_log("Error in get_links: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
?>
