# Run InteractiveMap test suite (requires docker compose up)
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")

Write-Host "==> composer install"
docker exec -u root lipetsk_web_apache bash -lc "command -v unzip >/dev/null || (apt-get update -qq && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq unzip >/dev/null)"
if (-not (Test-Path "composer.phar")) {
  Invoke-WebRequest -Uri "https://getcomposer.org/download/latest-stable/composer.phar" -OutFile "composer.phar" -UseBasicParsing
}
docker exec lipetsk_web_apache bash -lc "cd /var/www && php composer.phar install --no-interaction"

Write-Host "==> PHPUnit"
docker exec lipetsk_web_apache bash -lc "cd /var/www && ./vendor/bin/phpunit"

Write-Host "==> Node string-utils"
node --test tests/js/*.test.mjs

Write-Host "==> All done"
