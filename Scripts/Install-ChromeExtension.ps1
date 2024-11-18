# Definir o ID da extensão
$extensionId = "hgeljhfekpckiiplhkigfehkdpldcggm"

# Definir o caminho do registro
$registryPath = "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"

# Verificar se o caminho do registro existe, se não, criá-lo
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Obter o próximo número disponível para a nova entrada
$nextNumber = 1
while (Get-ItemProperty -Path $registryPath -Name $nextNumber -ErrorAction SilentlyContinue) {
    $nextNumber++
}

# Adicionar a extensão ao registro
New-ItemProperty -Path $registryPath -Name $nextNumber -Value "$extensionId;https://clients2.google.com/service/update2/crx" -PropertyType STRING -Force

Write-Host "A extensão $extensionId foi adicionada ao registro com sucesso."
