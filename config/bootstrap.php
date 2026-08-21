<?php
/**
 * Env + JSON helpers (без подключения к БД).
 */
function loadEnv($file = null) {
    if ($file === null) {
        $file = dirname(__DIR__) . DIRECTORY_SEPARATOR . '.env';
    }
    if (!file_exists($file)) {
        error_log("Warning: .env file not found: " . $file);
        return;
    }
    $lines = file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos(trim($line), '#') === 0) continue;
        if (empty(trim($line))) continue;
        list($name, $value) = explode('=', $line, 2);
        $name = trim($name);
        $value = trim($value, '"\'');
        $_ENV[$name] = $value;
    }
}

if (!isset($_ENV['DB_HOST'])) {
    loadEnv();
}

function jsonResponse($data, $status = 200) {
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}
