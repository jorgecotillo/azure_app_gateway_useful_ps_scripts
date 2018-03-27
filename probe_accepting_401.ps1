$gw = Get-AzureRmApplicationGateway -Name DTCodeGenAppGateway -ResourceGroupName DTPortalsDev

$match=New-AzureRmApplicationGatewayProbeHealthResponseMatch -StatusCode 200-401

Add-AzureRmApplicationGatewayProbeConfig -name HTTP_Unauthorized_Probe -ApplicationGateway $gw -Protocol Http -Path /test.html -Interval 30 -Timeout 120 -UnhealthyThreshold 3 -HostName "127.0.0.1" -Match $match

$probe = Get-AzureRmApplicationGatewayProbeConfig -name HTTP_Unauthorized_Probe -ApplicationGateway $gw

Set-AzureRmApplicationGatewayBackendHttpSettings -Name HTTP_WebApp -ApplicationGateway $gw -Port 80 -Protocol http -CookieBasedAffinity Disabled -RequestTimeout 500 -Probe $probe

Set-AzureRmApplicationGateway -ApplicationGateway $gw