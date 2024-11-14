#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Access Sharepoint List and Exclude Duplicated Itens by Title                  │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ TEST MODE [On - Display Write-Host Messages | Off - keep Silent               │
#└───────────────────────────────────────────────────────────────────────────────┘

$ShowDebugOutput = $true

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Simple check                                                                  │
#└───────────────────────────────────────────────────────────────────────────────┘

#Install-Module PnP.PowerShell
if (-not(Test-Connection 8.8.8.8 -Quiet)) {exit}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Fill the variables with right information of Sharepoint List                  │
#│ Here we use Rest method to interact with sharepoint list                      │
#└───────────────────────────────────────────────────────────────────────────────┘

$Global:configXML             = "C:\Program Files\SharepointCustomManagement\Settings\Config.xml"

$Global:ConfigXMLClientID     = "" # Client ID
$Global:ConfigXMLClientSecret = "" # Client Secret
$Global:ConfigXMLSiteUrl      = "" # Sharepoint
$Global:ConfigXMLListName     = "" # Name of Sharepoint List

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Functions and Main Variables                                                  │
#└───────────────────────────────────────────────────────────────────────────────┘

function Write-TestMessage {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message2
    )
    
    if ($ShowDebugOutput) {
        $currentDate = Get-Date -Format "dd-MM-yyyy'T'HH'H'mm'M'"
        Write-Host -ForegroundColor Gray "$currentDate " -NoNewline; Write-Host -ForegroundColor Cyan $Message2
    }
}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Interact with SP List and perform actions                                     │
#└───────────────────────────────────────────────────────────────────────────────┘

Write-TestMessage -Message2 "Connecting to SharePoint"
Connect-PnPOnline -Url $ConfigXMLSiteUrl -ClientId $ConfigXMLClientID -ClientSecret $ConfigXMLClientSecret -WarningAction Ignore

Write-TestMessage -Message2 "Importing SharePoint List: $ConfigXMLListName"
$SharePointListData = Get-PnPListItem -List $ConfigXMLListName -PageSize 5000

$uniqueItems = @{}
$duplicateItems = @()

Write-TestMessage -Message2 "Identifying duplicate items"
foreach ($item in $SharePointListData) {
    $title = $item["Title"]
    
    if ($uniqueItems.ContainsKey($title)) {
    
        $duplicateItems += $item
    } else {
       
        $uniqueItems[$title] = $item
    }
}

Write-TestMessage -Message2 "Found $($duplicateItems.Count) duplicate items"

foreach ($duplicateItem in $duplicateItems) {
    $itemId = $duplicateItem.Id
    $itemTitle = $duplicateItem["Title"]
    
    Write-TestMessage -Message2 "Removing duplicate item: ID $itemId, Title '$itemTitle'"
    Remove-PnPListItem -List $ConfigXMLListName -Identity $itemId -Force
}

Write-TestMessage -Message2 "Duplicate removal process completed"

$uniqueItems = $null
$duplicateItems = $null
Disconnect-PnPOnline

Write-TestMessage -Message2 "Script execution completed"
