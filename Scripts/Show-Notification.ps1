#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Create a simple notification with personalized message                        │
#└───────────────────────────────────────────────────────────────────────────────┘

function Show-Notification {
    param (
        [Parameter(Mandatory=$true)]
        [string]$BalloonTipText,
        [string]$BalloonTipTitle = "Notification",
        [System.Windows.Forms.ToolTipIcon]$BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info,
        [int]$Duration = 5000
    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    $notifyIcon = New-Object System.Windows.Forms.NotifyIcon
    $notifyIcon.Icon = [System.Drawing.SystemIcons]::Information

    $notifyIcon.Visible = $true

    $notifyIcon.BalloonTipTitle = $BalloonTipTitle
    $notifyIcon.BalloonTipText = $BalloonTipText
    $notifyIcon.BalloonTipIcon = $BalloonTipIcon

    $notifyIcon.ShowBalloonTip($Duration)

    Start-Sleep -Milliseconds $Duration

    $notifyIcon.Dispose()
}


Show-Notification -BalloonTipText "Just a sample to test"
