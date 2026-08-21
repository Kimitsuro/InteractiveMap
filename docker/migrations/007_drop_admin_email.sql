-- Email администратора не используется (вход только по login).
ALTER TABLE administrators DROP COLUMN IF EXISTS email;
