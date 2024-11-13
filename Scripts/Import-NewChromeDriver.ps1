#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

Remove-Variable * -ErrorAction SilentlyContinue # Clear all variables

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Check Available ChromeDriver Versions                                         │
#└───────────────────────────────────────────────────────────────────────────────┘

$ChromeDriver = (Invoke-WebRequest -Uri "https://googlechromelabs.github.io/chrome-for-testing/known-good-versions-with-downloads.json").Content
$ChromeDriverVersions = $ChromeDriver | ConvertFrom-Json

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Check Current Google Chrome Version                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

$ChromeCurrentVersion = (Get-Item (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)').VersionInfo.ProductVersion
$ChromeCurrentVersionPrefix = ($ChromeCurrentVersion -split '\.')[0..2] -join '.'
$ChromeCurrentVersionPrefix2 = ($ChromeCurrentVersion -split '\.')[0..1] -join '.'

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Now the script will try to capture the closest chrome driver version          │
#│ with your version of Google Chrome                                            │
#└───────────────────────────────────────────────────────────────────────────────┘

$matchFound = $false
$partialMatchUrls = [PSCustomObject]@{}
$partialMatchUrls2 = [PSCustomObject]@{}

$ChromeDriverVersions.versions | ForEach-Object {
    $win64Url = $_.downloads.chromedriver | Where-Object { $_.platform -eq 'win64' } | Select-Object -ExpandProperty url
    if ($win64Url -match $ChromeCurrentVersion) {
        $RightObject0 = $win64Url
        Write-Host -ForegroundColor Green $win64Url
        $matchFound = $true
    } elseif ($win64Url -match $ChromeCurrentVersionPrefix) {
        $partialMatchUrls | Add-Member -NotePropertyName $win64Url -NotePropertyValue $win64Url
    } elseif ($win64Url -match $ChromeCurrentVersionPrefix2) {
        $partialMatchUrls2 | Add-Member -NotePropertyName $win64Url -NotePropertyValue $win64Url
    }
}

if (-not $matchFound) {
    if ($partialMatchUrls.PSObject.Properties.Count -gt 0) {
        $RightObject1 = ($partialMatchUrls.PSObject.Properties.Value | Sort-Object | Select-Object -Last 1)
        Write-Host -ForegroundColor Yellow $RightObject1
        $matchFound = $true
    } elseif ($partialMatchUrls2.PSObject.Properties.Count -gt 0) {
        $RightObject2 = ($partialMatchUrls2.PSObject.Properties.Value | Sort-Object | Select-Object -Last 1)
        Write-Host -ForegroundColor Cyan $RightObject2
    }
}

if (-not([string]::IsNullOrWhiteSpace($RightObject0))) {$URL = $RightObject0}
if (-not([string]::IsNullOrWhiteSpace($RightObject1))) {$URL = $RightObject1}
if (-not([string]::IsNullOrWhiteSpace($RightObject2))) {$URL = $RightObject2}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Download the ChromeDriver to temp folder                                      │
#└───────────────────────────────────────────────────────────────────────────────┘

$FILE = "C:\temp\chromedriver-win64.zip"
$tempFILE = "C:\temp"
$tempFILEsub = "C:\temp\chromedriver-win64"

if (-not(Test-Path -Path $tempFILE)) { [void](New-Item $tempFILE -ItemType Directory) }

(New-Object System.Net.WebClient).DownloadFile($URL, $FILE)

Expand-Archive $FILE -DestinationPath $tempFILE -Force

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Here i chose the folder to extract the ChromeDriver                           │
#│ In my case, I use ChromeDriver to Selenium powershell module                  │
#│ You can just choose another folder                                            │
#└───────────────────────────────────────────────────────────────────────────────┘

$seleniumPath = (Get-Module -ListAvailable Selenium).ModuleBase

Copy-Item -Path "C:\temp\chromedriver-win64\chromedriver.exe" -Destination "$seleniumPath\assemblies" -Force

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Exclude temp folders                                                          │
#└───────────────────────────────────────────────────────────────────────────────┘

if (test-path $FILE){Remove-Item $FILE}
if (test-path $tempFILEsub){Remove-Item $tempFILEsub -Recurse}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ End                                                                           │
#└───────────────────────────────────────────────────────────────────────────────┘
