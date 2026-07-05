<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';
require_once __DIR__ . '/../../config/validation.php';
require_once __DIR__ . '/../../src/Database.php';

initSecureSession();
applySecurityHeaders();
sendCorsHeaders(['POST']);

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
    http_response_code(204);
    exit;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    jsonResponse(['error' => 'Method not allowed'], 405);
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input || empty($input['login']) || empty($input['email']) || empty($input['password']) || empty($input['full_name'])) {
    jsonResponse(['error' => 'Invalid JSON or missing fields: login, email, password, full_name'], 400);
}

requireAdminSetupAccess($input['setup_key'] ?? null);

$login = trim($input['login']);
$password = $input['password'];
$full_name = trim($input['full_name']);

if (strlen($login) < 3 || strlen($password) < 8) {
    jsonResponse(['error' => 'Login must be at least 3 characters, password at least 8'], 400);
}

try {
    $email = validateAndNormalizeEmail(trim($input['email']));
} catch (InvalidArgumentException $e) {
    jsonResponse(['error' => $e->getMessage()], 400);
}

try {
    $pdo = Database::getInstance();
    $checkSql = "SELECT id FROM administrators WHERE login = ? OR email = ?";
    $existing = Database::query($checkSql, [$login, $email]);
    if (!empty($existing)) {
        jsonResponse(['error' => 'Login or email already exists'], 409);
    }

    $password_hash = password_hash($password, PASSWORD_DEFAULT);
    $insertSql = "INSERT INTO administrators (login, email, password_hash, full_name) VALUES (?, ?, ?, ?) RETURNING id";
    $adminId = Database::fetchOne($insertSql, [$login, $email, $password_hash, $full_name]);

    if ($adminId) {
        jsonResponse([
            'success' => true,
            'id' => $adminId,
            'message' => 'Администратор создан. Войдите через /admin.',
        ], 201);
    }

    jsonResponse(['error' => 'Failed to create admin'], 500);
} catch (Exception $e) {
    error_log("Error in register: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
?>
