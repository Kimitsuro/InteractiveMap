<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class AuthTest extends TestCase
{
    private TestHttpClient $http;
    private string $login;
    private string $password;

    protected function setUp(): void
    {
        $this->http = new TestHttpClient();
        $this->login = getenv('TEST_ADMIN_LOGIN') ?: 'test_admin';
        $this->password = getenv('TEST_ADMIN_PASS') ?: 'TestAdminPass123!';
    }

    public function testLoginFailsWithWrongPassword(): void
    {
        $res = $this->http->postJson('/api/login.php', [
            'login' => $this->login,
            'password' => 'definitely-wrong-password',
        ]);
        $this->assertSame(401, $res['status']);
    }

    public function testLoginLogoutFlow(): void
    {
        $res = $this->http->postJson('/api/login.php', [
            'login' => $this->login,
            'password' => $this->password,
        ]);
        $this->assertSame(200, $res['status'], $res['body']);
        $this->assertTrue($res['json']['success'] ?? false);

        $session = $this->http->get('/api/check_session.php');
        $this->assertTrue($session['json']['loggedIn'] ?? false);

        $log = $this->http->get('/api/get_action_log.php?limit=5');
        $this->assertSame(200, $log['status'], $log['body']);
        $this->assertArrayHasKey('logs', $log['json'] ?? []);

        $logout = $this->http->postJson('/api/logout.php', []);
        $this->assertSame(200, $logout['status']);

        $after = $this->http->get('/api/check_session.php');
        $this->assertFalse($after['json']['loggedIn'] ?? true);
    }
}
