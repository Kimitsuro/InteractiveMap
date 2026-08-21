<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../src/Database.php';

initApi(['methods' => ['GET'], 'method' => 'GET', 'admin' => true, 'credentials' => true]);

$limit = isset($_GET['limit']) ? (int) $_GET['limit'] : 50;
if ($limit < 1) {
    $limit = 50;
}
if ($limit > 200) {
    $limit = 200;
}

try {
    $rows = Database::query(
        "SELECT
            al.id,
            al.action,
            al.entity,
            al.record_id,
            al.created_at,
            a.login AS admin_login,
            a.full_name AS admin_name
         FROM action_log al
         LEFT JOIN administrators a ON a.id = al.administrator_id
         ORDER BY al.id DESC
         LIMIT ?",
        [$limit]
    );
    jsonResponse(['logs' => $rows]);
} catch (Exception $e) {
    error_log('Error in get_action_log: ' . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
