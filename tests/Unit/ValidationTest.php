<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class ValidationTest extends TestCase
{
    public function testTrimNullable(): void
    {
        $this->assertNull(trimNullable(null));
        $this->assertNull(trimNullable(''));
        $this->assertNull(trimNullable('   '));
        $this->assertSame('abc', trimNullable('  abc  '));
    }

    public function testValidateHttpUrlOk(): void
    {
        $this->assertSame(
            'https://example.com/path',
            validateHttpUrl('https://example.com/path', 'Сайт')
        );
    }

    public function testValidateHttpUrlNull(): void
    {
        $this->assertNull(validateHttpUrl(null, 'Сайт'));
        $this->assertNull(validateHttpUrl('  ', 'Сайт'));
    }

    public function testValidateHttpUrlRequiresScheme(): void
    {
        $this->expectException(InvalidArgumentException::class);
        validateHttpUrl('example.com', 'Сайт');
    }

    public function testValidateHttpUrlTooLong(): void
    {
        $this->expectException(InvalidArgumentException::class);
        validateHttpUrl('https://example.com/' . str_repeat('a', 600), 'Сайт', 500);
    }

    public function testValidateInstitutionName(): void
    {
        $this->assertSame('МБОУ СШ №1', validateInstitutionName('  МБОУ СШ №1  '));
    }

    public function testValidateInstitutionNameEmpty(): void
    {
        $this->expectException(InvalidArgumentException::class);
        validateInstitutionName('');
    }

    public function testValidateInstitutionType(): void
    {
        $this->assertSame('school', validateInstitutionType('school'));
    }

    public function testValidateInstitutionTypeInvalid(): void
    {
        $this->expectException(InvalidArgumentException::class);
        validateInstitutionType('academy');
    }

    public function testValidateRangeMinGreaterThanMax(): void
    {
        $this->expectException(InvalidArgumentException::class);
        validateRangeForType('school', 5.0, 2.0);
    }

    public function testValidateRangePreschoolOk(): void
    {
        [$min, $max] = validateRangeForType('preschool', 1.5, 7.0);
        $this->assertSame(1.5, $min);
        $this->assertSame(7.0, $max);
    }

    public function testValidateRangeClearedForSpo(): void
    {
        [$min, $max] = validateRangeForType('spo', 1.0, 5.0);
        $this->assertNull($min);
        $this->assertNull($max);
    }

    public function testValidateCodeList(): void
    {
        $codes = validateCodeList(['autism', 'autism', 'hearing_impairment'], CONDITION_CODES, 'ОВЗ');
        $this->assertSame(['autism', 'hearing_impairment'], $codes);
    }

    public function testValidateCodeListInvalid(): void
    {
        $this->expectException(InvalidArgumentException::class);
        validateCodeList(['unknown'], CONDITION_CODES, 'ОВЗ');
    }

    public function testValidateAndNormalizeEmail(): void
    {
        $this->assertSame('a@b.co', validateAndNormalizeEmail('a@b.co'));
    }

    public function testValidateAndNormalizeEmailInvalid(): void
    {
        $this->expectException(InvalidArgumentException::class);
        validateAndNormalizeEmail('not-an-email');
    }

    public function testValidateAoopPrograms(): void
    {
        $out = validateAoopPrograms([
            ['name' => 'АООП ТНР', 'url' => 'https://example.com/a.pdf'],
            ['name' => '  '],
        ]);
        $this->assertCount(1, $out);
        $this->assertSame('АООП ТНР', $out[0]['name']);
        $this->assertSame('https://example.com/a.pdf', $out[0]['url']);
    }
}
