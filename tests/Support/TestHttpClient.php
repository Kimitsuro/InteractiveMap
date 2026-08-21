<?php
declare(strict_types=1);

/**
 * Minimal HTTP client with cookie jar for API integration tests.
 */
final class TestHttpClient
{
    private string $baseUrl;
    private string $cookieFile;

    public function __construct(?string $baseUrl = null)
    {
        $this->baseUrl = rtrim($baseUrl ?? (getenv('TEST_BASE_URL') ?: 'http://127.0.0.1'), '/');
        $this->cookieFile = sys_get_temp_dir() . '/im_test_cookies_' . getmypid() . '.txt';
        if (file_exists($this->cookieFile)) {
            unlink($this->cookieFile);
        }
    }

    public function __destruct()
    {
        if (file_exists($this->cookieFile)) {
            @unlink($this->cookieFile);
        }
    }

    public function clearCookies(): void
    {
        if (file_exists($this->cookieFile)) {
            unlink($this->cookieFile);
        }
    }

    /**
     * @return array{status:int, body:string, json:?array}
     */
    public function request(string $method, string $path, ?array $jsonBody = null): array
    {
        $url = $this->baseUrl . $path;
        $ch = curl_init($url);
        if ($ch === false) {
            throw new RuntimeException('curl_init failed');
        }

        $headers = ['Accept: application/json'];
        curl_setopt_array($ch, [
            CURLOPT_CUSTOMREQUEST => strtoupper($method),
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HEADER => false,
            CURLOPT_FOLLOWLOCATION => false,
            CURLOPT_COOKIEJAR => $this->cookieFile,
            CURLOPT_COOKIEFILE => $this->cookieFile,
            CURLOPT_TIMEOUT => 30,
        ]);

        if ($jsonBody !== null) {
            $payload = json_encode($jsonBody, JSON_UNESCAPED_UNICODE);
            $headers[] = 'Content-Type: application/json';
            curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
        }

        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $body = curl_exec($ch);
        if ($body === false) {
            $err = curl_error($ch);
            curl_close($ch);
            throw new RuntimeException('HTTP request failed: ' . $err);
        }
        $status = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        $decoded = json_decode($body, true);
        return [
            'status' => $status,
            'body' => $body,
            'json' => is_array($decoded) ? $decoded : null,
        ];
    }

    public function get(string $path): array
    {
        return $this->request('GET', $path);
    }

    public function postJson(string $path, array $data): array
    {
        return $this->request('POST', $path, $data);
    }
}
