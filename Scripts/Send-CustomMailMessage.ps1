#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ HINT: the HTML body suports variables                                         │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Main Information                                                              │
#└───────────────────────────────────────────────────────────────────────────────┘

$sendMailMessageSplat = @{
    From = 'mail@mail.com'
    To = 'mail@mail.com'
    Subject = "An Subject to Mail"
    SmtpServer = 'smtpserver'
}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Body Informations                                                             │
#└───────────────────────────────────────────────────────────────────────────────┘

$alertStatus = "Offline"
$alertColor = "red"
$message = "We have detected a problem."
$action1 = "Do something 01"
$action2 = "Do something 02"

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ HTML Body                                                                     │
#└───────────────────────────────────────────────────────────────────────────────┘

$Body = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Alert</title>
</head>
<body style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; background-color: #151A2C; color: #fff; margin: 5px;">
    <center>
    <table style="background-color: #3333; padding: 20px; margin-left: 30px; margin-right: 30px; max-width: 600px; ">
        <tr>
            <td colspan="3" style="padding: 10px; text-align: center; background-color: #262C3F; margin: 10%;">
                <h1 style="color: #EB8200; margin: 5%;">Monitoring Alert</h1>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #151A2C; padding: 20px; text-align: center;">
                <h2>Status Alerts <span style="color: $alertColor;">$alertStatus</span>.</h2>
                <p>Olá,</p>
                <p>$message</p>
                <p>🤖</p>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #262C3F; padding: 20px; margin-bottom: 30px; text-align: Center;">
                <p><strong>Next Actions</strong></p>
                <p><strong>1ª:</strong> $action1;</p>
                <p><strong>2ª:</strong> $action2.</p>
                <table style="width: 100%; margin-left: 10px;">
                    <tr>

                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="padding: 20px; text-align: center; background-color: #151A2C;">
                <div class="ssl-certificate">
                    <p style="font-style: italic; font-size: 10px;">Do not respond to this email. Messages are automatic and not monitored.</p>
                </div>
            </td>
        </tr>
    </table>
    </center>
</body>
</html>
"@
      
#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Send mail                                                                     │
#└───────────────────────────────────────────────────────────────────────────────┘

Send-MailMessage -SmtpServer $sendMailMessageSplat.SmtpServer -From $sendMailMessageSplat.From -to $sendMailMessageSplat.To -Subject $sendMailMessageSplat.Subject -BodyAsHtml $Body -Encoding UTF8
