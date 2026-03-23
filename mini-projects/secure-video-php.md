<?php

$applicationKeyId = "*********";
$applicationKey = "******";
$bucketName = "moodle-secure-videos";
$bucketId = "f***********d";

// get video name
$fileName = $_GET['video'] ?? '';

if (!$fileName) {
    echo "No video specified";
    exit;
}

// Step 1: Authorize
$auth = curl_init("https://api.backblazeb2.com/b2api/v2/b2_authorize_account");
curl_setopt($auth, CURLOPT_USERPWD, "$applicationKeyId:$applicationKey");
curl_setopt($auth, CURLOPT_RETURNTRANSFER, true);
$response = json_decode(curl_exec($auth), true);
curl_close($auth);

if (!isset($response['authorizationToken'])) {
    echo "Authorization failed";
    exit;
}

$apiUrl = $response['apiUrl'];
$authToken = $response['authorizationToken'];

// Step 2: Get temporary access
$data = [
    "bucketId" => $bucketId,
    "fileNamePrefix" => $fileName,
    "validDurationInSeconds" => 3600
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
    echo "Failed to generate download token";
    exit;
}

$downloadAuthToken = $result['authorizationToken'];

// Step 3: Generate secure URL
$secureUrl = "https://f005.backblazeb2.com/file/$bucketName/$fileName?Authorization=$downloadAuthToken";

// redirect
header("Location: $secureUrl");
exit;

?>
