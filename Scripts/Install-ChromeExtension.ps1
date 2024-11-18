#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
#│ Define Chrome Extension ID                                                                                        │
#│ Ex.: https://chromewebstore.google.com/detail/auto-refresh-plus-page-mo/hgeljhfekpckiiplhkigfehkdpldcggm          │
#│ Id is last code on PATH https://chromewebstore.google.com/detail/auto-refresh-plus-page-mo/*******************    │
#└───────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
$extensionId = "hgeljhfekpckiiplhkigfehkdpldcggm"

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ REG path                                                                      │
#└───────────────────────────────────────────────────────────────────────────────┘
$registryPath = "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"

#┌───────────────────────────────────────────────────────────────────────────────┐
#│  Check Reg path                                                               │
#└───────────────────────────────────────────────────────────────────────────────┘
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

$nextNumber = 1
while (Get-ItemProperty -Path $registryPath -Name $nextNumber -ErrorAction SilentlyContinue) {
    $nextNumber++
}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│  Add ID on registry                                                           │
#└───────────────────────────────────────────────────────────────────────────────┘
New-ItemProperty -Path $registryPath -Name $nextNumber -Value "$extensionId;https://clients2.google.com/service/update2/crx" -PropertyType STRING -Force
