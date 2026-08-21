<?php
/**
 * Создание администратора из консоли сервера (без секретных ключей).
 *
 * Пример:
 *   docker exec lipetsk_web_apache php /var/www/docker/create_admin.php admin StrongPass123 "Иванов И.И."
 */
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../src/Database.php';

if (PHP_SAPI !== 'cli') {
    fwrite(STDERR, "Скрипт можно запускать только из консоли.\n");
    exit(1);
}

if ($argc < 4) {
    fwrite(STDERR, "Использование: php create_admin.php <login> <password> <full_name>\n");
    exit(1);
}

$login = trim($argv[1]);
$password = $argv[2];
$fullName = trim($argv[3]);

if (strlen($login) < 3 || strlen($password) < 8) {
    fwrite(STDERR, "Логин минимум 3 символа, пароль минимум 8.\n");
    exit(1);
}

try {
    $existing = Database::query(
        "SELECT id FROM administrators WHERE login = ?",
        [$login]
    );
    if (!empty($existing)) {
        fwrite(STDERR, "Логин уже существует.\n");
        exit(1);
    }

    $passwordHash = password_hash($password, PASSWORD_DEFAULT);
    $adminId = Database::fetchOne(
        "INSERT INTO administrators (login, password_hash, full_name) VALUES (?, ?, ?) RETURNING id",
        [$login, $passwordHash, $fullName]
    );

    if (!$adminId) {
        fwrite(STDERR, "Не удалось создать администратора.\n");
        exit(1);
    }

    echo "Администратор создан, id={$adminId}. Войдите через /admin.\n";
    exit(0);
} catch (Exception $e) {
    fwrite(STDERR, "Ошибка: " . $e->getMessage() . "\n");
    exit(1);
}
