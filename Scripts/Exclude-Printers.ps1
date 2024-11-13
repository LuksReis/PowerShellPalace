#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

$Printer = Get-Printer | where {
    (
    $_.Name -NotMatch "PullPrint" -and
    $_.Name -NotMatch "Fax" -and
    $_.Name -NotMatch "Microsoft Print to PDF" -and
    $_.Name -NotMatch "Microsoft XPS Document Writer" -and
    $_.Name -NotMatch "OneNote (Desktop)" -and
    $_.Name -NotMatch "OneNote for Windows 10" -and
    $_.DriverName -NotMatch "Zebra" -and
    $_.DriverName -NotMatch "Zdesigner" -and
    $_.DriverName -NotMatch "Intermec"
    )
}

if($Printer){Remove-Printer -InputObject $Printer}
