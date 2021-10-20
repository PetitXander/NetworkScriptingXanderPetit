$users = Get-ADGroupMember -Identity Secretariaat

foreach ($user in $users) {
$name = $user.SamAccountName
Set-ADUser -Identity $user -Profilepath "\\Win07-DC2\Profiles$\$name"
}
