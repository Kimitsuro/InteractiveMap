<?php
/**
 * PDO-подключение к PostgreSQL.
 * jsonResponse / loadEnv — в bootstrap.php; телефоны/email — в formatters.php.
 */
require_once __DIR__ . '/bootstrap.php';
require_once __DIR__ . '/formatters.php';

$host = $_ENV['DB_HOST'] ?? null;
$port = $_ENV['DB_PORT'] ?? '5432';
$dbname = $_ENV['DB_NAME'] ?? null;
$username = $_ENV['DB_USER'] ?? null;
$password = $_ENV['DB_PASS'] ?? null;
$sslmode = $_ENV['DB_SSLMODE'] ?? 'disable';

if ($host === null || $dbname === null || $username === null || $password === null || $password === '') {
    error_log('DB config incomplete: set DB_HOST, DB_NAME, DB_USER, DB_PASS in .env');
    http_response_code(500);
    die('Internal Server Error: Database configuration missing.');
}

$dsn = "pgsql:host=$host;port=$port;dbname=$dbname;sslmode=$sslmode";

try {
    $pdo = new PDO($dsn, $username, $password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
        PDO::ATTR_STRINGIFY_FETCHES => false,
        PDO::ATTR_CASE => PDO::CASE_NATURAL,
    ]);
} catch (PDOException $e) {
    error_log('DB Connection Error: ' . $e->getMessage());
    http_response_code(500);
    die('Internal Server Error: Database connection failed.');
}
