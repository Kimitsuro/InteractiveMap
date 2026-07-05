<?php
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/security.php';

initApi(['methods' => ['POST'], 'method' => 'POST', 'credentials' => true]);

$input = json_decode(file_get_contents('php://input'), true);
if (!$input || empty($input['login']) || empty($input['password'])) {
    jsonResponse(['error' => 'Invalid JSON or missing credentials'], 400);
}

$login = trim($input['login']);
$password = $input['password'];
$ip = getClientIp();

checkLoginRateLimit($ip);

try {
    $pdo = Database::getInstance();
    $stmt = $pdo->prepare("SELECT id, password_hash FROM administrators WHERE login = ?");
    $stmt->execute([$login]);
    $admin = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($admin && password_verify($password, $admin['password_hash'])) {
        session_regenerate_id(true);
        $_SESSION['admin_id'] = $admin['id'];
        ensureCsrfToken();

        $updateStmt = $pdo->prepare("UPDATE administrators SET last_login = CURRENT_TIMESTAMP, updated_at = CURRENT_TIMESTAMP WHERE id = ?");
        $updateStmt->execute([$admin['id']]);

        clearLoginAttempts($ip);

        jsonResponse([
            'success' => true,
            'csrfToken' => $_SESSION['csrf_token'],
        ]);
    }

    recordFailedLogin($ip);
    jsonResponse(['error' => 'Invalid credentials'], 401);
} catch (Exception $e) {
    error_log("Error in login: " . $e->getMessage());
    jsonResponse(['error' => 'Internal server error'], 500);
}
?>
