<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../src/Database.php';

initApi(['methods' => ['GET'], 'method' => 'GET', 'admin' => true, 'credentials' => true]);

try {
    $search = $_GET['search'] ?? '';

    $sql = "SELECT id, full_name, phone, email FROM directors WHERE 1=1";
    $params = [];

    if (!empty($search)) {
        $sql .= " AND full_name ILIKE ?";
        $params[] = "%$search%";
    }

    $sql .= " ORDER BY full_name";

    $directors = Database::query($sql, $params);

    jsonResponse(['directors' => $directors]);
} catch (Exception $e) {
    error_log("Error in get_directors: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
?>
