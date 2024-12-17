function Search-Bitlocker {

    param (        [string]$computer    )

############

$Start = Get-Date

Import-Module ActiveDirectory -ErrorAction SilentlyContinue

# Get computer Distinguished Name

$computerName = Get-ADComputer -Identity $computer -server latam.syngenta.org -Properties * -ErrorAction SilentlyContinue

# Get bitlocker infos
$recoveryObjects = Get-ADObject -Filter { objectClass -eq "msFVE-RecoveryInformation" } -SearchBase $computerName.DistinguishedName -Server latam.syngenta.org -Properties msFVE-RecoveryGuid, msFVE-RecoveryPassword -ErrorAction SilentlyContinue

# New object
$recoveryKeys = @{
    Hostname = $computer
    ElapsedTime = $null
    RecoveryKeys = @()
}

# If results is not null
if ($recoveryObjects) {
    foreach ($obj in $recoveryObjects) {
        # Get guid result to string
        $recoveryGuid = if ($obj.'msFVE-RecoveryGuid') {
            [Guid]::New($obj.'msFVE-RecoveryGuid').ToString()
        } else {
            "GUID not found"
        }

        # Add results to object
        $recoveryKeys.RecoveryKeys += @{
            RecoveryKeyID = $recoveryGuid
            Password = $obj.'msFVE-RecoveryPassword'
        }
    }
} else {
    $RecoveryPassword = "Bitlocker recovery not found"
}


$End = Get-Date

$Duration = $End - $Start

$recoveryKeys.ElapsedTime = $Duration.ToString()


# Convert result to Json
$jsonOutput = $recoveryKeys | ConvertTo-Json -Depth 3

    return $jsonOutput
    

}
