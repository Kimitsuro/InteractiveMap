<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class InstitutionCrudTest extends TestCase
{
    private TestHttpClient $http;
    private string $login;
    private string $password;
    private ?int $createdId = null;
    private ?int $directorId = null;

    protected function setUp(): void
    {
        $this->http = new TestHttpClient();
        $this->login = getenv('TEST_ADMIN_LOGIN') ?: 'test_admin';
        $this->password = getenv('TEST_ADMIN_PASS') ?: 'TestAdminPass123!';

        $login = $this->http->postJson('/api/login.php', [
            'login' => $this->login,
            'password' => $this->password,
        ]);
        $this->assertSame(200, $login['status'], 'Login failed: ' . $login['body']);
    }

    protected function tearDown(): void
    {
        if ($this->createdId !== null) {
            $this->http->postJson('/api/delete_institution.php', ['id' => $this->createdId]);
            $this->createdId = null;
        }
    }

    public function testCreateUpdateDeleteInstitution(): void
    {
        $districts = $this->http->get('/api/get_districts.php');
        $this->assertSame(200, $districts['status']);
        $districtId = (int) array_key_first($districts['json']['districts']);

        $unique = 'TEST_CRUD_' . time() . '_' . random_int(1000, 9999);
        $create = $this->http->postJson('/api/create_institution.php', [
            'name' => $unique,
            'district_id' => $districtId,
            'type' => 'school',
            'description' => 'phpunit',
            'address' => 'тест',
            'website' => 'https://example.com/',
            'aoop_url' => null,
            'range' => ['min' => 1, 'max' => 11],
            'conditions' => ['autism'],
            'conditionsAdmission' => ['certificate'],
            'aoop_programs' => [
                ['name' => 'TEST AOOP', 'url' => 'https://example.com/aoop.pdf'],
            ],
            'director' => [
                'name' => 'Тестов Тест Тестович',
                'phone' => '+7 (900) 111-22-33',
                'email' => 'test.director.' . time() . '@example.local',
            ],
        ]);

        $this->assertSame(201, $create['status'], $create['body']);
        $this->createdId = (int) ($create['json']['id'] ?? 0);
        $this->assertGreaterThan(0, $this->createdId);

        $get = $this->http->get('/api/get_institution.php?id=' . $this->createdId);
        $this->assertSame(200, $get['status'], $get['body']);
        $inst = $get['json']['institution'];
        $this->assertSame($unique, $inst['name']);
        $this->assertSame('school', $inst['type']);
        $this->assertSame('Тестов Тест Тестович', $inst['director']['name']);
        $this->directorId = isset($inst['director']['id']) ? (int) $inst['director']['id'] : null;
        $this->assertNotNull($this->directorId);

        $updatedName = $unique . '_UPD';
        $update = $this->http->postJson('/api/update_institution.php', [
            'id' => $this->createdId,
            'name' => $updatedName,
            'district_id' => $districtId,
            'type' => 'school',
            'description' => 'phpunit-upd',
            'address' => 'тест 2',
            'website' => 'https://example.com/upd',
            'aoop_url' => null,
            'range' => ['min' => 1, 'max' => 9],
            'conditions' => [],
            'conditionsAdmission' => ['certificate'],
            'aoop_programs' => [],
            'director' => [
                'id' => $this->directorId,
                'name' => 'Тестов Тест Тестович',
                'phone' => '+79001112233',
                'email' => $inst['director']['email'],
            ],
        ]);
        $this->assertSame(200, $update['status'], $update['body']);

        $get2 = $this->http->get('/api/get_institution.php?id=' . $this->createdId);
        $this->assertSame($updatedName, $get2['json']['institution']['name']);
        $this->assertSame(
            $this->directorId,
            (int) $get2['json']['institution']['director']['id'],
            'Director row must stay the same on update'
        );

        $delete = $this->http->postJson('/api/delete_institution.php', ['id' => $this->createdId]);
        $this->assertSame(200, $delete['status'], $delete['body']);
        $deletedId = $this->createdId;
        $this->createdId = null;

        $gone = $this->http->get('/api/get_institution.php?id=' . $deletedId);
        $this->assertSame(404, $gone['status']);

        // Director should be removed with institution
        $dir = $this->http->get('/api/get_director.php?id=' . $this->directorId);
        $this->assertTrue(
            in_array($dir['status'], [404, 400], true) || (($dir['json']['error'] ?? null) !== null),
            'Expected director gone after institution delete, got: ' . $dir['body']
        );
    }
}
