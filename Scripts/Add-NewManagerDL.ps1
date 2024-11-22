#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

Connect-ExchangeOnline

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Distribution List Name                                                        │
#└───────────────────────────────────────────────────────────────────────────────┘

$dlName = "DISPLAYNAME"

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Add co-owner to DL                                                            │
#└───────────────────────────────────────────────────────────────────────────────┘

Set-DistributionGroup -Identity $dlName -ManagedBy @{Add="vitor.aquino@syngenta.com"}

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Check current owners/managers                                                 │
#└───────────────────────────────────────────────────────────────────────────────┘

Get-DistributionGroup -Identity $dlName | Select-Object -ExpandProperty ManagedBy

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Bulk search to DLs with similar names, and add new owner                      │
#└───────────────────────────────────────────────────────────────────────────────┘

$dls = Get-DistributionGroup -Filter {DisplayName -like "$dlName*"}

foreach ($dl in $dls) {
    Set-DistributionGroup -Identity $dl.DisplayName -ManagedBy @{Add="ADDMAILHERE"}
}
