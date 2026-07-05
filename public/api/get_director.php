<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../src/Database.php';

initApi(['methods' => ['GET'], 'method' => 'GET', 'admin' => true, 'credentials' => true]);

if (!isset($_GET['id'])) {
    jsonResponse(['error' => 'Director ID is required'], 400);
}

$directorId = (int) $_GET['id'];

try {
    $sql = "SELECT id, full_name, phone, email FROM directors WHERE id = ?";
    $directors = Database::query($sql, [$directorId]);

    if (empty($directors)) {
        jsonResponse(['error' => 'Director not found'], 404);
    }

    jsonResponse(['director' => $directors[0]]);
} catch (Exception $e) {
    error_log("Error in get_director: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
?>
