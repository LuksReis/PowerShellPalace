#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Add your Azure APP infos                                                      │
#└───────────────────────────────────────────────────────────────────────────────┘

$tenantId     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$clientId     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$clientSecret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Endpoint
$tokenUrl = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

# Request body
$body = @{
    client_id     = $clientId
    scope         = "https://graph.microsoft.com/.default"
    client_secret = $clientSecret
    grant_type    = "client_credentials"
}

# Send request and receive an response
$response = Invoke-RestMethod -Method Post -Uri $tokenUrl -Body $body -ContentType "application/x-www-form-urlencoded"

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Token received                                                                │
#└───────────────────────────────────────────────────────────────────────────────┘
$token = $response.access_token
$token

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ You can test the Token                                                        │
#└───────────────────────────────────────────────────────────────────────────────┘

$apiUrl = "https://graph.microsoft.com/v1.0/users"

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type"  = "application/json"
}

$result = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method GET

$result
