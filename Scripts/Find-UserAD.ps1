#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Assemblys                                                                     │
#└───────────────────────────────────────────────────────────────────────────────┘

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Main XAML                                                                     │
#└───────────────────────────────────────────────────────────────────────────────┘

[xml]$MainXAML = @"

<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        Title="AD Utility" Height="300" Width="583">
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="7"/>
            <ColumnDefinition Width="142"/>
            <ColumnDefinition Width="9"/>
            <ColumnDefinition Width="400"/>
            <ColumnDefinition Width="9"/>
            <ColumnDefinition Width="Auto"/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="5"/>
            <RowDefinition Height="50"/>
            <RowDefinition Height="5"/>
            <RowDefinition Height="50"/>
            <RowDefinition Height="5"/>
            <RowDefinition Height="50"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="5"/>
            <RowDefinition Height="50"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="5"/>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <Label Content="User:" Grid.Row="1" Grid.Column="1" VerticalContentAlignment="Center" FontFamily="Microsoft JhengHei" Margin="10,5,10,5" FontSize="16" />
        <TextBox x:Name="textUSER" Grid.Column="3" HorizontalAlignment="Left" Margin="10,10,0,10" Grid.Row="1" TextWrapping="Wrap" Text="USER" Width="254" VerticalContentAlignment="Center" FontFamily="Microsoft JhengHei" FontSize="16"/>
        <Button x:Name="buttonSEARCH" Grid.Column="3" Content="Search" HorizontalAlignment="Left" Margin="310,0,0,0" Grid.Row="1" VerticalAlignment="Center" Width="63" VerticalContentAlignment="Center" HorizontalContentAlignment="Center" BorderBrush="Black" FontSize="18"/>
        <Label Content="Email:" Grid.Row="3" Grid.Column="1" VerticalContentAlignment="Center" FontFamily="Microsoft JhengHei" Margin="10,5,10,5" FontSize="16" />
        <Label x:Name="labelEMAIL" Content="-" Grid.Row="3" Grid.Column="3" VerticalContentAlignment="Center" FontFamily="Microsoft JhengHei" Margin="10,5,136,5" FontSize="16" FontWeight="Bold" />
        <Label Content="Name:" Grid.Row="5" Grid.Column="1" VerticalContentAlignment="Center" FontFamily="Microsoft JhengHei" Margin="10,5,10,5" FontSize="16" />
        <Label x:Name="labelNAME" Content="-" Grid.Row="5" Grid.Column="3" VerticalContentAlignment="Center" FontFamily="Microsoft JhengHei" Margin="10,5,136,5" FontSize="16" FontWeight="Bold" />
        <Label Content="Department:" Grid.Row="8" Grid.Column="1" VerticalContentAlignment="Center" FontFamily="Microsoft JhengHei" Margin="10,5,10,5" FontSize="16" />
        <Label x:Name="labelDEPARTMENT" Content="-" Grid.Row="8" Grid.Column="3" VerticalContentAlignment="Center" FontFamily="Microsoft JhengHei" Margin="10,5,136,5" FontSize="16" FontWeight="Bold" />
    </Grid>
</Window>

"@

$MainXAML.Window.RemoveAttribute('x:Class')
$MainXAML.Window.RemoveAttribute('mc:Ignorable')
$MainXAMLReader = New-Object System.Xml.XmlNodeReader $MainXAML
$MainWindow = [Windows.Markup.XamlReader]::Load($MainXAMLReader)

# Interactions

$Global:textUSER = $MainWindow.FindName("textUSER")
$Global:ButtonSEARCH = $MainWindow.FindName("buttonSEARCH")
$Global:labelEMAIL = $MainWindow.FindName("labelEMAIL")
$Global:labelNAME = $MainWindow.FindName("labelNAME")
$Global:labelDEPARTMENT = $MainWindow.FindName("labelDEPARTMENT")

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Functions                                                                     │
#└───────────────────────────────────────────────────────────────────────────────┘

function Get-UserProfile {
    param(
        [Parameter(Mandatory=$true)]
        [string]$userAD,       
        [string]$ADServerGeneral = "latam.syngenta.org"
    )

    $User = Get-ADUser -Filter { SamAccountName -eq $userAD } -Server $ADServerGeneral -Properties SamAccountName # Try to find using SamAccountName, if not find try next
    if (!$User) { $User = Get-ADUser -Filter { mail -eq $userAD } -Server $ADServerGeneral -Properties SamAccountName    } # Try to find using mail, if not find try next
    if (!$User) { $User = Get-ADUser -Filter { DisplayName -eq $userAD } -Server $ADServerGeneral -Properties SamAccountName    }  # Try to find using Display Name, if not find try next
    if ($User) {  $Global:userProfile = Get-AdUser -Identity $User.SamAccountName -Server $ADServerGeneral -Properties * ; return $Global:userProfile   } else {$Global:userProfile = "-" } # if not find fill "-"
}

function Update-UserGUI {

    $MainWindow.Dispatcher.Invoke([action]{
       [System.Windows.Threading.DispatcherPriority]::Background
    }, [System.Windows.Threading.DispatcherPriority]::Background)
    
}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Actions                                                                       │
#└───────────────────────────────────────────────────────────────────────────────┘

$Global:ButtonSEARCH.add_Click({

    Get-UserProfile $Global:textUSER.text


    if($userProfile){
    
    $Global:labelEMAIL.Content = $userProfile.mail
    $Global:labelNAME.Content = $userProfile.Name
    $Global:labelDEPARTMENT.Content = $userProfile.department

    Update-UserGUI

    }
    
})

$MainWindow.ShowDialog() | Out-Null
