<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class FormattersTest extends TestCase
{
    public function testNormalizePhonePlus7(): void
    {
        $this->assertSame('+74742250137', normalizePhone('+7 (4742) 25-01-37'));
    }

    public function testNormalizePhoneFrom8(): void
    {
        $this->assertSame('+79001234567', normalizePhone('8 (900) 123-45-67'));
    }

    public function testNormalizePhoneTenDigits(): void
    {
        $this->assertSame('+79001234567', normalizePhone('9001234567'));
    }

    public function testNormalizePhoneLocalSixDigits(): void
    {
        $this->assertSame('251137', normalizePhone('25-11-37'));
    }

    public function testNormalizePhoneEmpty(): void
    {
        $this->assertNull(normalizePhone(null));
        $this->assertNull(normalizePhone('   '));
    }

    public function testNormalizePhoneInvalidChars(): void
    {
        $this->expectException(InvalidArgumentException::class);
        normalizePhone('abc');
    }

    public function testNormalizePhoneTooShort(): void
    {
        $this->expectException(InvalidArgumentException::class);
        normalizePhone('12345');
    }

    public function testFormatPhoneForDisplayMobile(): void
    {
        $this->assertSame('+7 (900) 123-45-67', formatPhoneForDisplay('+79001234567'));
    }

    public function testFormatPhoneForDisplayCity4742(): void
    {
        $this->assertSame('+7 (4742) 25-01-37', formatPhoneForDisplay('+74742250137'));
    }

    public function testFormatPhoneForDisplayYelets5DigitCode(): void
    {
        $this->assertSame('+7 (47467) 2-22-22', formatPhoneForDisplay('+74746722222'));
    }

    public function testFormatPhoneForDisplayDobrinka5DigitCode(): void
    {
        $this->assertSame('+7 (47462) 1-23-45', formatPhoneForDisplay('+74746212345'));
    }

    public function testNormalizeEmailForDisplaySimple(): void
    {
        $this->assertSame('user@example.com', normalizeEmailForDisplay('user@example.com'));
    }

    public function testNormalizeEmailForDisplayNull(): void
    {
        $this->assertNull(normalizeEmailForDisplay(null));
        $this->assertSame('', normalizeEmailForDisplay(''));
    }
}
