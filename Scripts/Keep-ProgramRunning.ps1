#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Keep an program running                                                       │
#└───────────────────────────────────────────────────────────────────────────────┘

$Program = "C:\Program Files\ZoomRooms\bin\ZoomRooms.exe"

while($true){

    $runningProcess = (Get-Process).ProcessName

    if ($runningProcess -notmatch "ZoomRooms") {Start-Process -FilePath $Program }

    Start-Sleep -Seconds 60

}
