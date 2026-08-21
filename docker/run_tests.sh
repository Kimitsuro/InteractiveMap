#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."

echo "==> composer install"
docker exec -u root lipetsk_web_apache bash -lc 'command -v unzip >/dev/null || (apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq unzip >/dev/null)'
docker exec lipetsk_web_apache bash -lc 'cd /var/www && (test -f composer.phar || php -r "copy(\"https://getcomposer.org/download/latest-stable/composer.phar\", \"composer.phar\");") && php composer.phar install --no-interaction'

echo "==> PHPUnit"
docker exec lipetsk_web_apache bash -lc 'cd /var/www && ./vendor/bin/phpunit'

echo "==> Node string-utils"
node --test tests/js/*.test.mjs

echo "==> All done"
