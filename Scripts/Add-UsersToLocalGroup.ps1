#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Created By   : Lucas Reis                                                     │
#│ Contact      : lmarioreis@gmail.com                                           │
#└───────────────────────────────────────────────────────────────────────────────┘

#┌───────────────────────────────────────────────────────────────────────────────┐
#│ Add users manually to Local Groups                                            │
#└───────────────────────────────────────────────────────────────────────────────┘

$users = @("DOMAIN\User1", "DOMAIN\User2")
foreach ($user in $users) {
    Add-LocalGroupMember -Group "Administrators" -Member $user
}
