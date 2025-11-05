#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

[string]$Global:WallpaperPath = "C:\PATH\WallpaperIT.png"
[string]$Global:mainpath = "C:\PATH"

if(!(Test-Path $mainpath)) {[void](New-Item -Path $mainpath -ItemType Directory -Force)}

function Set-WallpaperWithRefresh {

    $code = @'
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    
    public const int SPI_SETDESKWALLPAPER = 0x14;
    public const int SPIF_UPDATEINIFILE = 0x01;
    public const int SPIF_SENDCHANGE = 0x02;
}
'@

    if (-not ("Wallpaper" -as [type])) {
        Add-Type -TypeDefinition $code
    }

    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $WallpaperPath

    [Wallpaper]::SystemParametersInfo([Wallpaper]::SPI_SETDESKWALLPAPER, 0, $WallpaperPath, 
        [Wallpaper]::SPIF_UPDATEINIFILE -bor [Wallpaper]::SPIF_SENDCHANGE)

}

Set-WallpaperWithRefresh
