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

function formatPhoneLocalPart(string $local): string {
    if (strlen($local) === 6) {
        return substr($local, 0, 2) . '-' . substr($local, 2, 2) . '-' . substr($local, 4, 2);
    }
    if (strlen($local) === 5) {
        return substr($local, 0, 1) . '-' . substr($local, 1, 2) . '-' . substr($local, 3, 2);
    }
    if (strlen($local) === 7) {
        return substr($local, 0, 3) . '-' . substr($local, 3, 2) . '-' . substr($local, 5, 2);
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

    if ($national[0] === '9') {
        return $normalized;
    }

    if ($national[0] === '4') {
        $areaCodes5 = [
            '47467', '47465', '47466', '47471', '47472', '47474',
            '47475', '47477', '47461', '47463', '47464', '47468', '47469',
        ];
        foreach ($areaCodes5 as $area) {
            if (str_starts_with($national, $area)) {
                $local = substr($national, strlen($area));
                return '+7 (' . $area . ') ' . formatPhoneLocalPart($local);
            }
        }

        if (preg_match('/^(474\d)(\d{6})$/', $national, $parts)) {
            return '+7 (' . $parts[1] . ') ' . formatPhoneLocalPart($parts[2]);
        }

        if (preg_match('/^(474)(\d{7})$/', $national, $parts)) {
            return '+7 (' . $parts[1] . ') ' . formatPhoneLocalPart($parts[2]);
        }
    }

    return $normalized;
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
