# Created by: Lucas Reis - lucas.reis@syngenta.com
# ---- Exclude printers

$Printer = Get-Printer | where {
    (
    $_.Name -NotMatch "PullPrint" -and
    $_.Name -NotMatch "IMP-TORRE02-COLORIDA-ADM" -and
    $_.Name -NotMatch "IMP-TORRE02-COLORIDA-PRODUCAO" -and
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

ETIQUETA-TORRE02-ADM
ETIQUETA-TORRE02-PRODUCAO

IMP-TORRE02-COLORIDA-ADM
IMP-TORRE02-COLORIDA-PRODUCAO


$Printer = Get-Printer

$Printer.DriverName -match "PCL"