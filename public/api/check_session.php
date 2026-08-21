<?php
require_once __DIR__ . '/../../config/bootstrap.php';
require_once __DIR__ . '/../../config/security.php';

initApi(['methods' => ['GET'], 'method' => 'GET', 'credentials' => true]);

jsonResponse(['loggedIn' => !empty($_SESSION['admin_id'])]);
