#!/usr/bin/env php
<?php
/**
 * Apply SQL migrations from docker/migrations/ in filename order.
 * Usage:
 *   docker exec lipetsk_web_apache php /var/www/docker/apply_migrations.php
 *   php docker/apply_migrations.php   (with DB_* in .env)
 */
declare(strict_types=1);

require_once dirname(__DIR__) . '/config/database.php';
require_once dirname(__DIR__) . '/src/Database.php';

$dir = __DIR__ . '/migrations';
$files = glob($dir . '/*.sql');
sort($files, SORT_STRING);

$pdo = Database::getInstance();

$pdo->exec(
    "CREATE TABLE IF NOT EXISTS schema_migrations (
        filename VARCHAR(255) PRIMARY KEY,
        applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )"
);

$applied = $pdo->query('SELECT filename FROM schema_migrations')->fetchAll(PDO::FETCH_COLUMN);
$appliedSet = array_flip($applied);

$ran = 0;
foreach ($files as $path) {
    $name = basename($path);
    if ($name === '000_schema_migrations.sql') {
        // already ensured above
        if (!isset($appliedSet[$name])) {
            $pdo->prepare('INSERT INTO schema_migrations (filename) VALUES (?)')->execute([$name]);
            echo "Recorded: $name\n";
            $ran++;
        }
        continue;
    }
    if (isset($appliedSet[$name])) {
        echo "Skip: $name\n";
        continue;
    }

    $sql = file_get_contents($path);
    if ($sql === false || trim($sql) === '') {
        fwrite(STDERR, "Empty migration: $name\n");
        exit(1);
    }

    try {
        $pdo->beginTransaction();
        $pdo->exec($sql);
        $pdo->prepare('INSERT INTO schema_migrations (filename) VALUES (?)')->execute([$name]);
        $pdo->commit();
        echo "Applied: $name\n";
        $ran++;
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        fwrite(STDERR, "Failed $name: " . $e->getMessage() . "\n");
        exit(1);
    }
}

echo $ran === 0 ? "Nothing to apply.\n" : "Done. Applied/recorded: $ran\n";
