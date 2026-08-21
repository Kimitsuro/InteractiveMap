<?php
/**
 * Нормализация телефонов и email для API.
 */
require_once __DIR__ . '/bootstrap.php';

function normalizePhone(?string $phone): ?string {
    if ($phone === null || trim($phone) === '') {
        return null;
    }

    $phone = trim($phone);

    if (preg_match('/[^0-9+\s()\-–—]/u', $phone)) {
        throw new InvalidArgumentException('Телефон содержит недопустимые символы. Разрешены только цифры, +, пробелы, скобки и дефисы.');
    }

    $hasPlus = str_starts_with($phone, '+');
    $digits = preg_replace('/\D/', '', $phone);

    if ($digits === '') {
        throw new InvalidArgumentException('Укажите номер телефона цифрами.');
    }

    if (strlen($digits) === 6 && !$hasPlus && $digits[0] !== '7' && $digits[0] !== '8') {
        return $digits;
    }

    if (strlen($digits) === 11 && $digits[0] === '8') {
        $digits = '7' . substr($digits, 1);
    }

    if (strlen($digits) === 11 && $digits[0] === '7') {
        return '+7' . substr($digits, 1);
    }

    if (strlen($digits) === 10) {
        return '+7' . $digits;
    }

    if ($hasPlus && str_starts_with($phone, '+7') && strlen($digits) === 11 && $digits[0] === '7') {
        return '+7' . substr($digits, 1);
    }

    throw new InvalidArgumentException('Неверный формат телефона. Укажите +7 и 10 цифр или домашний номер из 6 цифр.');
}

/** Коды районных центров Липецкой области (5 цифр + 5 цифр номера). Липецк — 4742. */
function lipetskDistrictAreaCodes(): array {
    return [
        '47461', // Грязи
        '47462', // Добринка
        '47463', // Доброе
        '47464', // Лев Толстой
        '47465', // Данков
        '47466', // Лебедянь
        '47467', // Елец
        '47468', // Долгоруково
        '47469', // Красное
        '47471', // Задонск
        '47472', // Усмань
        '47473', // Волово
        '47474', // Тербуны
        '47475', // Чаплыгин
        '47476', // Становое
        '47477', // Хлевное
        '47478', // Измалково
    ];
}

function formatPhoneLocalPart(string $local): string {
    if (strlen($local) === 7) {
        return substr($local, 0, 3) . '-' . substr($local, 3, 2) . '-' . substr($local, 5, 2);
    }
    if (strlen($local) === 6) {
        return substr($local, 0, 2) . '-' . substr($local, 2, 2) . '-' . substr($local, 4, 2);
    }
    if (strlen($local) === 5) {
        return substr($local, 0, 1) . '-' . substr($local, 1, 2) . '-' . substr($local, 3, 2);
    }
    return $local;
}

function formatPhoneForDisplay(?string $phone): ?string {
    if ($phone === null || trim($phone) === '') {
        return $phone;
    }

    try {
        $normalized = normalizePhone($phone);
    } catch (InvalidArgumentException $e) {
        return $phone;
    }

    if ($normalized === null) {
        return null;
    }

    if (preg_match('/^\d{6}$/', $normalized)) {
        return formatPhoneLocalPart($normalized);
    }

    if (!preg_match('/^\+7(\d{10})$/', $normalized, $matches)) {
        return $phone;
    }

    $national = $matches[1];

    // Мобильный: +7 (9XX) XXX-XX-XX
    if ($national[0] === '9') {
        return '+7 (' . substr($national, 0, 3) . ') '
            . substr($national, 3, 3) . '-'
            . substr($national, 6, 2) . '-'
            . substr($national, 8, 2);
    }

    // Липецк: +7 (4742) XX-XX-XX
    if (str_starts_with($national, '4742')) {
        return '+7 (4742) ' . formatPhoneLocalPart(substr($national, 4));
    }

    // Районные центры: +7 (474XX) X-XX-XX
    foreach (lipetskDistrictAreaCodes() as $area) {
        if (str_starts_with($national, $area)) {
            return '+7 (' . $area . ') ' . formatPhoneLocalPart(substr($national, 5));
        }
    }

    // Прочий городской: +7 (XXX) XXX-XX-XX
    return '+7 (' . substr($national, 0, 3) . ') '
        . substr($national, 3, 3) . '-'
        . substr($national, 6, 2) . '-'
        . substr($national, 8, 2);
}

function normalizeEmailForDisplay(?string $email): ?string {
    if ($email === null || trim($email) === '') {
        return $email;
    }
    $email = trim($email);
    if (!str_contains($email, '@')) {
        return $email;
    }
    [$local, $domain] = explode('@', $email, 2);
    if (!function_exists('idn_to_utf8')) {
        return $email;
    }
    $unicodeDomain = idn_to_utf8($domain, IDNA_DEFAULT, INTL_IDNA_VARIANT_UTS46);
    if ($unicodeDomain === false) {
        return $email;
    }
    return $local . '@' . $unicodeDomain;
}
