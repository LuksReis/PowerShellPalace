## Welcome to PowerShell Palace!

<h1>Powershell Basics</h1>

<h2>Enabling Script Execution</h2>

<p>You can create .ps1 files [Powershell Scripts] using <img src="https://img.shields.io/badge/PowerShell%20ISE-5391FE" /> and/or <img src="https://img.shields.io/badge/Visual%20Studio%20Code-8A2BE2" /> </p>
<p>By default, if you have never executed a PowerShell script before, you need to enable script execution by changing the execution policy. You can do this using the following command:</p>

```powershell
Set-ExecutionPolicy Bypass
````

<h2>Admin Permissions</h2>

When creating scripts that perform system-level operations such as modifying registry keys, installing programs, or making other significant changes to the system, you must run these scripts with administrative privileges. 

1. Right-click on the PowerShell icon
2. Select "Run as Administrator"
3. When prompted, click "Yes" to allow the program to make changes to your device

Alternatively, you can start a PowerShell session with elevated privileges from an existing PowerShell window by running:

```powershell
Start-Process PowerShell -Verb RunAs
````

<h2>Lets GO!</h2>

You can go to scripts here: [PowerShellPalace](https://github.com/LuksReis/PowerShellPalace/tree/main/Scripts)
