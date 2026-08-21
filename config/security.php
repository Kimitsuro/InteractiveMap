<?php

function initSecureSession(): void {
    if (session_status() === PHP_SESSION_ACTIVE) {
        return;
    }

    $secure = filter_var($_ENV['SESSION_SECURE'] ?? 'false', FILTER_VALIDATE_BOOLEAN);

    session_set_cookie_params([
        'lifetime' => 0,
        'path' => '/',
        'httponly' => true,
        'secure' => $secure,
        'samesite' => 'Lax',
    ]);

    session_start();
}

function applySecurityHeaders(): void {
    header('X-Content-Type-Options: nosniff');
    header('X-Frame-Options: SAMEORIGIN');
    header('Referrer-Policy: strict-origin-when-cross-origin');
    header('Permissions-Policy: geolocation=(), microphone=(), camera=()');
}

function sendCorsHeaders(array $methods = ['GET'], bool $allowCredentials = false): void {
    $allowedOrigin = trim($_ENV['ALLOWED_ORIGIN'] ?? '');
    $origin = $_SERVER['HTTP_ORIGIN'] ?? '';

    if ($allowedOrigin === '*') {
        header('Access-Control-Allow-Origin: *');
    } elseif ($allowedOrigin !== '' && $origin === $allowedOrigin) {
        header('Access-Control-Allow-Origin: ' . $allowedOrigin);
        if ($allowCredentials) {
            header('Access-Control-Allow-Credentials: true');
        }
    }

    header('Access-Control-Allow-Methods: ' . implode(', ', $methods));
    header('Access-Control-Allow-Headers: Content-Type');
}

function getClientIp(): string {
    return $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
}

function requireAdmin(): void {
    if (empty($_SESSION['admin_id'])) {
        jsonResponse(['error' => 'Unauthorized'], 401);
    }
}

function getLoginAttemptsFile(string $ip): string {
    return rtrim(sys_get_temp_dir(), DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR . 'lipetsk_login_' . hash('sha256', $ip) . '.json';
}

function checkLoginRateLimit(string $ip, int $maxAttempts = 5, int $windowSeconds = 900): void {
    $file = getLoginAttemptsFile($ip);
    if (!file_exists($file)) {
        return;
    }

    $data = json_decode((string) file_get_contents($file), true);
    if (!is_array($data)) {
        return;
    }

    $recent = array_filter($data, static fn($timestamp) => (time() - (int) $timestamp) < $windowSeconds);
    if (count($recent) >= $maxAttempts) {
        jsonResponse(['error' => 'Слишком много попыток входа. Попробуйте позже.'], 429);
    }
}

function recordFailedLogin(string $ip): void {
    $file = getLoginAttemptsFile($ip);
    $data = [];

    if (file_exists($file)) {
        $decoded = json_decode((string) file_get_contents($file), true);
        if (is_array($decoded)) {
            $data = $decoded;
        }
    }

    $data[] = time();
    file_put_contents($file, json_encode($data), LOCK_EX);
}

function clearLoginAttempts(string $ip): void {
    $file = getLoginAttemptsFile($ip);
    if (file_exists($file)) {
        unlink($file);
    }
}

function initApi(array $options = []): void {
    initSecureSession();
    applySecurityHeaders();

    $methods = $options['methods'] ?? ['GET'];
    sendCorsHeaders($methods, !empty($options['credentials']));

    if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'OPTIONS') {
        http_response_code(204);
        exit;
    }

    $allowedMethod = $options['method'] ?? null;
    if ($allowedMethod !== null && ($_SERVER['REQUEST_METHOD'] ?? '') !== $allowedMethod) {
        jsonResponse(['error' => 'Method not allowed'], 405);
    }

    if (!empty($options['admin'])) {
        requireAdmin();
    }
}

?>
