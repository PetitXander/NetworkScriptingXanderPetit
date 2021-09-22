Get-ADForest | Set-ADForest -UPNSuffixes @{add="mijnschool.be"}

$Suffix =  "mijnschool.be"
$LocalUsers = Get-ADUser -Filter {UserPrincipalName -like '*intranet.mijnschool.be'} -Properties UserPrincipalName -ResultSetSize $nul
$LocalUsers | foreach {$newUpn = $_.UserPrincipalName.Replace("intranet.mijnschool.be",$Suffix); $_ | Set-ADUser -UserPrincipalName $newUpn}