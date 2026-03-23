<?php
// ==========================================
// Secure Video Streaming via Backblaze B2
// ==========================================

// ⚠️ Replace with ENV variables in production
$applicationKeyId = "YOUR_KEY_ID";
$applicationKey   = "YOUR_APPLICATION_KEY";
$bucketName       = "moodle-secure-videos";
$bucketId         = "YOUR_BUCKET_ID";

// 🎯 Get video name safely
$fileName = basename($_GET['video'] ?? '');

if (!$fileName) {
    http_response_code(400);
    echo "No video specified";
    exit;
}

// ✅ Optional: allow only specific files
$allowedVideos = [
    "01-Intro.mp4",
    "02-Network-device.mp4",
    "03-routing-basics.mp4",
    "04-switching.mp4",
    "05-firewall-basics.mp4"
];

if (!in_array($fileName, $allowedVideos)) {
    http_response_code(403);
    echo "Invalid video request";
    exit;
}

// ==========================================
// Step 1: Authorize with Backblaze
// ==========================================
$auth = curl_init("https://api.backblazeb2.com/b2api/v2/b2_authorize_account");

curl_setopt($auth, CURLOPT_USERPWD, "$applicationKeyId:$applicationKey");
curl_setopt($auth, CURLOPT_RETURNTRANSFER, true);

$response = json_decode(curl_exec($auth), true);
curl_close($auth);

if (!isset($response['authorizationToken'])) {
    http_response_code(500);
    echo "Authorization failed";
    exit;
}

$apiUrl    = $response['apiUrl'];
$authToken = $response['authorizationToken'];

// ==========================================
// Step 2: Generate temporary download token
// ==========================================
$data = [
    "bucketId" => $bucketId,
    "fileNamePrefix" => $fileName,
    "validDurationInSeconds" => 1800 // 30 minutes
];

$ch = curl_init("$apiUrl/b2api/v2/b2_get_download_authorization");

curl_setopt($ch, CURLOPT_HTTPHEADER, [
    "Authorization: $authToken",
    "Content-Type: application/json"
]);

curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$result = json_decode(curl_exec($ch), true);
curl_close($ch);

if (!isset($result['authorizationToken'])) {
    http_response_code(500);
    echo "Failed to generate download token";
    exit;
}

$downloadAuthToken = $result['authorizationToken'];

// ==========================================
// Step 3: Redirect to secure video URL
// ==========================================
$secureUrl = "https://f005.backblazeb2.com/file/$bucketName/$fileName?Authorization=$downloadAuthToken";

header("Location: $secureUrl");
exit;

?>
