
#get users in secretariaat
$users = Get-ADGroupMember -Identity Secretariaat

#voor elke user voeg profilepath toe
foreach ($user in $users) {
$name = $user.SamAccountName
Set-ADUser -Identity $user -Profilepath "\\Win07-DC2\Profiles$\$name"
}
