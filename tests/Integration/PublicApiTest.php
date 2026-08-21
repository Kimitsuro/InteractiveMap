<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class PublicApiTest extends TestCase
{
    private TestHttpClient $http;

    protected function setUp(): void
    {
        $this->http = new TestHttpClient();
    }

    public function testGetDistricts(): void
    {
        $res = $this->http->get('/api/get_districts.php');
        $this->assertSame(200, $res['status']);
        $this->assertIsArray($res['json']['districts'] ?? null);
        $this->assertNotEmpty($res['json']['districts']);
    }

    public function testGetInstitutionsRequiresDistrictId(): void
    {
        $res = $this->http->get('/api/get_institutions.php');
        $this->assertSame(400, $res['status']);
        $this->assertArrayHasKey('error', $res['json'] ?? []);
    }

    public function testGetInstitutionsForDistrict(): void
    {
        $districts = $this->http->get('/api/get_districts.php');
        $id = (int) array_key_first($districts['json']['districts']);
        $res = $this->http->get('/api/get_institutions.php?district_id=' . $id);
        $this->assertSame(200, $res['status']);
        $this->assertIsArray($res['json']['institutions'] ?? null);
        $this->assertArrayHasKey('total', $res['json'] ?? []);
        $this->assertArrayHasKey('page', $res['json'] ?? []);
        $this->assertArrayHasKey('page_size', $res['json'] ?? []);
        $this->assertSame(1, (int) $res['json']['page']);
        $this->assertSame(10, (int) $res['json']['page_size']);
        $this->assertLessThanOrEqual(10, count($res['json']['institutions']));
        $this->assertLessThanOrEqual((int) $res['json']['total'], count($res['json']['institutions']));
    }

    public function testGetInstitutionsInvalidPage(): void
    {
        $districts = $this->http->get('/api/get_districts.php');
        $id = (int) array_key_first($districts['json']['districts']);
        $res = $this->http->get('/api/get_institutions.php?district_id=' . $id . '&page=0');
        $this->assertSame(400, $res['status']);
        $this->assertArrayHasKey('error', $res['json'] ?? []);
    }

    public function testGetInstitutionsPaginationPagesDoNotOverlap(): void
    {
        $districts = $this->http->get('/api/get_districts.php');
        $id = (int) array_key_first($districts['json']['districts']);

        $page1 = $this->http->get('/api/get_institutions.php?district_id=' . $id . '&page=1&page_size=10');
        $this->assertSame(200, $page1['status']);
        $total = (int) ($page1['json']['total'] ?? 0);
        if ($total <= 10) {
            $this->assertLessThanOrEqual(10, count($page1['json']['institutions'] ?? []));
            return;
        }

        $page2 = $this->http->get('/api/get_institutions.php?district_id=' . $id . '&page=2&page_size=10');
        $this->assertSame(200, $page2['status']);
        $this->assertSame(2, (int) $page2['json']['page']);

        $ids1 = array_map(static fn($row) => (int) $row['id'], $page1['json']['institutions'] ?? []);
        $ids2 = array_map(static fn($row) => (int) $row['id'], $page2['json']['institutions'] ?? []);
        $this->assertNotEmpty($ids1);
        $this->assertNotEmpty($ids2);
        $this->assertSame([], array_values(array_intersect($ids1, $ids2)));
    }

    public function testGetInstitutionsTypeFilterReducesTotal(): void
    {
        $districts = $this->http->get('/api/get_districts.php');
        $id = (int) array_key_first($districts['json']['districts']);

        $all = $this->http->get('/api/get_institutions.php?district_id=' . $id . '&page=1');
        $this->assertSame(200, $all['status']);
        $totalAll = (int) ($all['json']['total'] ?? 0);

        $filtered = $this->http->get('/api/get_institutions.php?district_id=' . $id . '&page=1&type[]=preschool');
        $this->assertSame(200, $filtered['status']);
        $totalFiltered = (int) ($filtered['json']['total'] ?? 0);

        $this->assertLessThanOrEqual($totalAll, $totalFiltered);
        foreach ($filtered['json']['institutions'] ?? [] as $inst) {
            $this->assertSame('preschool', $inst['type'] ?? null);
        }
    }

    public function testCheckSessionAnonymous(): void
    {
        $res = $this->http->get('/api/check_session.php');
        $this->assertSame(200, $res['status']);
        $this->assertFalse($res['json']['loggedIn'] ?? true);
    }

    public function testActionLogUnauthorized(): void
    {
        $res = $this->http->get('/api/get_action_log.php');
        $this->assertSame(401, $res['status']);
    }
}
