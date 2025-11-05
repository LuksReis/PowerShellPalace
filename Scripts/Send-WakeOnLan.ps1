#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

function Send-WOL {
    param(
        [Parameter(Mandatory=$true)][string]$mac,
        [string]$broadcast = "255.255.255.255",
        [int]$port = 9
    )

    $macBytes = ($mac -split '[:-]') | ForEach-Object { [byte] "0x$_" }
    $packet = [byte[]](,0xFF * 6 + ($macBytes * 16))

    $udpClient = New-Object System.Net.Sockets.UdpClient
    $udpClient.Connect($broadcast, $port)
    $udpClient.Send($packet, $packet.Length) | Out-Null
    $udpClient.Close()
}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Example                                                                       │
#└───────────────────────────────────────────────────────────────────────────────┘

Send-WOL -mac "52-A9-3E-F1-8B-F3"
