# InteractiveMap — карта образовательных учреждений Липецкой области

Интерактивная карта с фильтрами по типам учреждений, условиям обучения (ОВЗ) и адаптированным образовательным программам (АООП).

**Стек:** PHP 8.2, Apache, PostgreSQL 17, vanilla JavaScript.

---

## Быстрый старт (разработка)

1. Скопируйте `.env.example` в `.env` и задайте пароли.
2. Запустите dev-окружение:

```bash
docker compose up -d --build
```

3. Откройте http://localhost:8080  
4. Админка: http://localhost:8080/admin

Dev-конфиг (`docker-compose.yml`) включает pgAdmin (порт 5050), проброс PostgreSQL (5432) и монтирование кода для hot-reload.

---

## Production

```bash
docker compose -f docker-compose.prod.yml up -d --build
```

Отличия prod-конфигурации:
- нет pgAdmin;
- PostgreSQL не доступен снаружи;
- код запекается в Docker-образ (без volume `.:/var/www`);
- healthcheck для БД;
- `restart: unless-stopped`.

Порт веб-сервера задаётся в `.env`: `WEB_PORT=80`.

На HTTPS-сервере в `.env` установите:
```env
SESSION_SECURE=true
ALLOWED_ORIGIN=https://ваш-домен.рф
```

---

## Первый администратор

Регистрация через браузер **отключена**. Создайте админа с сервера:

```bash
curl -X POST http://localhost:8080/api/register.php \
  -H "Content-Type: application/json" \
  -H "X-Admin-Setup-Key: ваш-секрет-из-ADMIN_SETUP_SECRET" \
  -d "{\"login\":\"admin\",\"email\":\"admin@example.ru\",\"password\":\"StrongPass123\",\"full_name\":\"Иванов И.И.\"}"
```

Затем войдите через `/admin`.

---

## Импорт данных учреждений

1. Подготовьте исходный файл `docker/import_data/institutions_source.txt`.
2. Сгенерируйте SQL:

```bash
python docker/import_from_pdfs.py
```

3. Загрузите в БД (пример для dev):

```bash
docker cp docker/import_data/import.sql lipetsk_postgres:/tmp/import.sql
docker exec lipetsk_postgres psql -U user -d lipetsk_institutions_db -f /tmp/import.sql
```

---

## Структура проекта

| Путь | Назначение |
|------|------------|
| `public/` | Фронтенд и API (`public/api/`) |
| `config/` | БД, безопасность, валидация |
| `docker/init.sql` | Схема БД и справочники |
| `docker/import_data/` | Исходные данные и сгенерированный import.sql |
| `docker-compose.yml` | Dev |
| `docker-compose.prod.yml` | Production |

---

## Безопасность

- Пароли администраторов хранятся как `password_hash` (bcrypt).
- Mutating API защищены сессией и CSRF-токеном.
- `register.php` требует секрет `ADMIN_SETUP_SECRET`.
- Лимит попыток входа: 5 за 15 минут с одного IP.
- XSS: экранирование данных в карточках учреждений.

---

## Юридические страницы

- `/privacy.html` — обработка персональных данных (шаблон, уточните реквизиты департамента перед публикацией).
- Баннер о localStorage на главной странице.

---

## Переменные окружения

См. `.env.example`.

---

## Админка

- URL: `/admin`
- CRUD учреждений, журнал изменений в таблице `action_log`
- После сохранения карточки остаётся текущая страница списка
