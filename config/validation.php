<?php

const INSTITUTION_TYPES = ['preschool', 'school', 'school_internat', 'spo', 'vo'];

const CONDITION_CODES = [
    'hearing_impairment',
    'vision_impairment',
    'musculoskeletal_impairment',
    'speech_impairment',
    'mental_retardation',
    'autism',
    'multiple_disorders',
];

const ADMISSION_CODES = ['certificate', 'attestat'];

function validationError(string $message): void {
    jsonResponse(['error' => $message], 400);
}

function trimNullable(?string $value): ?string {
    if ($value === null) {
        return null;
    }
    $value = trim($value);
    return $value === '' ? null : $value;
}

function validateHttpUrl(?string $url, string $fieldLabel, int $maxLength = 500): ?string {
    $url = trimNullable($url);
    if ($url === null) {
        return null;
    }

    if (mb_strlen($url) > $maxLength) {
        throw new InvalidArgumentException("$fieldLabel слишком длинный (максимум $maxLength символов).");
    }

    if (!preg_match('/^https?:\/\//i', $url)) {
        throw new InvalidArgumentException("$fieldLabel должен начинаться с http:// или https://");
    }

    if (filter_var($url, FILTER_VALIDATE_URL) === false) {
        throw new InvalidArgumentException("Неверный формат: $fieldLabel");
    }

    $scheme = parse_url($url, PHP_URL_SCHEME);
    if (!in_array(strtolower((string) $scheme), ['http', 'https'], true)) {
        throw new InvalidArgumentException("$fieldLabel должен использовать протокол http или https");
    }

    return $url;
}

function validateAndNormalizeEmail(?string $email): ?string {
    $email = trimNullable($email);
    if ($email === null) {
        return null;
    }

    if (mb_strlen($email) > 100) {
        throw new InvalidArgumentException('Email слишком длинный (максимум 100 символов).');
    }

    if (!preg_match('/^[^\s@]+@[^\s@]+$/u', $email)) {
        throw new InvalidArgumentException('Неверный формат email.');
    }

    [$local, $domain] = explode('@', $email, 2);
    if ($local === '' || $domain === '') {
        throw new InvalidArgumentException('Неверный формат email.');
    }

    if (mb_strlen($local) > 64) {
        throw new InvalidArgumentException('Локальная часть email слишком длинная.');
    }

    $asciiDomain = $domain;
    if (function_exists('idn_to_ascii')) {
        $converted = idn_to_ascii($domain, IDNA_DEFAULT, INTL_IDNA_VARIANT_UTS46);
        if ($converted === false) {
            throw new InvalidArgumentException('Неверный домен email.');
        }
        $asciiDomain = $converted;
        $asciiEmail = $local . '@' . $asciiDomain;
        if (!filter_var($asciiEmail, FILTER_VALIDATE_EMAIL)) {
            throw new InvalidArgumentException('Неверный формат email.');
        }
    } elseif (!preg_match('/^[^@\s]+@[^@\s]+\.[^@\s]+$/u', $email)) {
        throw new InvalidArgumentException('Неверный формат email.');
    }

    return normalizeEmailForDisplay($email);
}

function requireNormalizedEmail(?string $email): ?string {
    try {
        return validateAndNormalizeEmail($email);
    } catch (InvalidArgumentException $e) {
        validationError($e->getMessage());
    }
}

function validateDirectorName(?string $name): ?string {
    $name = trimNullable($name);
    if ($name === null) {
        return null;
    }

    if (mb_strlen($name) > 150) {
        throw new InvalidArgumentException('ФИО руководителя слишком длинное (максимум 150 символов).');
    }

    return $name;
}

function validateInstitutionName(?string $name): string {
    $name = trimNullable($name);
    if ($name === null) {
        throw new InvalidArgumentException('Укажите название учреждения.');
    }

    if (mb_strlen($name) > 255) {
        throw new InvalidArgumentException('Название учреждения слишком длинное (максимум 255 символов).');
    }

    return $name;
}

function validateInstitutionType(?string $type): string {
    $type = trimNullable($type);
    if ($type === null || !in_array($type, INSTITUTION_TYPES, true)) {
        throw new InvalidArgumentException('Неверный тип учреждения.');
    }

    return $type;
}

function validateDistrictId(int $districtId): int {
    if ($districtId <= 0) {
        throw new InvalidArgumentException('Укажите корректный район/округ.');
    }

    $exists = Database::fetchOne('SELECT id FROM districts WHERE id = ?', [$districtId]);
    if (!$exists) {
        throw new InvalidArgumentException('Район/округ не найден.');
    }

    return $districtId;
}

function validateCodeList(array $codes, array $allowed, string $fieldLabel): array {
    $normalized = [];
    foreach ($codes as $code) {
        $code = trim((string) $code);
        if ($code === '') {
            continue;
        }
        if (!in_array($code, $allowed, true)) {
            throw new InvalidArgumentException("Неверное значение в поле «$fieldLabel».");
        }
        $normalized[] = $code;
    }

    return array_values(array_unique($normalized));
}

function validateRangeForType(string $type, ?float $min, ?float $max): array {
    if (in_array($type, ['spo', 'vo'], true)) {
        return [null, null];
    }

    if ($min === null && $max === null) {
        return [null, null];
    }

    if ($type === 'preschool') {
        $minLimit = 1.5;
        $maxLimit = 8;
        $label = 'возраст';
    } else {
        $minLimit = 1;
        $maxLimit = 11;
        $label = 'класс';
    }

    if ($min !== null && ($min < $minLimit || $min > $maxLimit)) {
        throw new InvalidArgumentException("Минимальный $label должен быть от $minLimit до $maxLimit.");
    }

    if ($max !== null && ($max < $minLimit || $max > $maxLimit)) {
        throw new InvalidArgumentException("Максимальный $label должен быть от $minLimit до $maxLimit.");
    }

    if ($min !== null && $max !== null && $min > $max) {
        throw new InvalidArgumentException('Минимальное значение диапазона не может быть больше максимального.');
    }

    return [$min, $max];
}

function validateAoopPrograms(array $programs): array {
    $normalized = [];

    foreach ($programs as $program) {
        if (!is_array($program)) {
            throw new InvalidArgumentException('Неверный формат программы АООП.');
        }

        $name = trimNullable($program['name'] ?? null);
        if ($name === null) {
            continue;
        }

        if (mb_strlen($name) > 255) {
            throw new InvalidArgumentException('Название программы АООП слишком длинное (максимум 255 символов).');
        }

        $url = validateHttpUrl($program['url'] ?? null, 'Ссылка на программу АООП');

        $normalized[] = [
            'name' => $name,
            'url' => $url,
        ];
    }

    return $normalized;
}

function validateInstitutionPayload(array $input, bool $isUpdate = false): array {
    try {
        if ($isUpdate && empty($input['id'])) {
            throw new InvalidArgumentException('Не указан id учреждения.');
        }

        $type = validateInstitutionType($input['type'] ?? null);
        $districtId = validateDistrictId((int) ($input['district_id'] ?? 0));
        $rangeMin = isset($input['range']['min']) && $input['range']['min'] !== '' && $input['range']['min'] !== null
            ? (float) str_replace(',', '.', (string) $input['range']['min']) : null;
        $rangeMax = isset($input['range']['max']) && $input['range']['max'] !== '' && $input['range']['max'] !== null
            ? (float) str_replace(',', '.', (string) $input['range']['max']) : null;
        [$rangeMin, $rangeMax] = validateRangeForType($type, $rangeMin, $rangeMax);

        $director = null;
        if (!empty($input['director']['name'])) {
            $director = [
                'id' => isset($input['director']['id']) ? (int) $input['director']['id'] : null,
                'name' => validateDirectorName($input['director']['name']),
                'phone' => normalizePhone($input['director']['phone'] ?? null),
                'email' => validateAndNormalizeEmail($input['director']['email'] ?? null),
            ];
        }

        $validated = [
            'name' => validateInstitutionName($input['name'] ?? null),
            'district_id' => $districtId,
            'type' => $type,
            'description' => trimNullable($input['description'] ?? null),
            'address' => trimNullable($input['address'] ?? null),
            'website' => validateHttpUrl($input['website'] ?? null, 'Сайт учреждения'),
            'aoop_url' => validateHttpUrl($input['aoop_url'] ?? null, 'Общая ссылка на АООП'),
            'range' => [
                'min' => $rangeMin,
                'max' => $rangeMax,
            ],
            'conditions' => validateCodeList($input['conditions'] ?? [], CONDITION_CODES, 'Особые условия'),
            'conditionsAdmission' => validateCodeList($input['conditionsAdmission'] ?? [], ADMISSION_CODES, 'Условия приема'),
            'aoop_programs' => validateAoopPrograms($input['aoop_programs'] ?? []),
            'director' => $director,
        ];

        if ($isUpdate) {
            $validated['id'] = (int) $input['id'];
        }

        return $validated;
    } catch (InvalidArgumentException $e) {
        validationError($e->getMessage());
    }
}

?>
