#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ EXAMPLE of PowerShell Zabbix Sender                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Object with the information that will be sent                                 │
#│ Change to your data                                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

$speedtestOOKLA = [PSCustomObject]@{

        'Download' = $varDownload
        'Upload' = $varUpload
        'Location' = $varLocation
        'Server' = $varServer
        'Provider' = $varProvider
        'Latency' = $varLatency
        'IP' = $varPublicIP

}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Consume data and send to Zabbix                                               │
#│ Change to your data                                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Choose the group of data that you want to send on $json_result                │
#│ The ip of Zabbix server to receive data: -z 172.10.4.100                      │
#│ The name of host: -s "Monitoring OOkla"                                       │
#│ The tree of key name: -k mainspeedtest.ookla                                  │
#└───────────────────────────────────────────────────────────────────────────────┘

if ($speedtestOOKLA){

    $json_result = @{
        "#speedtestdownload#" = [int]$speedtestOOKLA.Download
        "#speedtestupload#" = [int]$speedtestOOKLA.Upload
        "#speedtestip#" = "#" + [string]$speedtestOOKLA.IP + "#"
        "#speedtestlatency#" = [int]$speedtestOOKLA.Latency
        "#speedtestlocation#" = "#" + [string]$speedtestOOKLA.Location + "#"
        "#speedtestprovider#" = "#" + [string]$speedtestOOKLA.Provider + "#"
        "#speedtestserver#" = "#" + [string]$speedtestOOKLA.Server + "#"
    }

    $json_new = $json_result | ConvertTo-Json -Compress

    # You need the Zabbix sender working on device
    & "C:\Program Files\Zabbix Agent 2\zabbix_sender.exe" -z 172.10.4.100 -s "Monitoring OOkla" -k mainspeedtest.ookla -o $json_new

}
