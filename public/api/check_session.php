<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';

initApi(['methods' => ['GET'], 'method' => 'GET', 'credentials' => true]);

$response = ['loggedIn' => !empty($_SESSION['admin_id'])];

if ($response['loggedIn']) {
    $response['csrfToken'] = ensureCsrfToken();
}

jsonResponse($response);
?>
