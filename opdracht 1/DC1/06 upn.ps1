Get-ADForest | Set-ADForest -UPNSuffixes @{add="mijnschool.be"}

$Oldsuffix = "intranet.mijnschool.be"
$Suffix =  "mijnschool.be"
$LocalUsers = Get-ADUser -Filter "UserPrincipalName -like '*$Oldsuffix'" -Properties UserPrincipalName -ResultSetSize $nul
$LocalUsers | foreach {$newUpn = $_.UserPrincipalName.Replace("intranet.mijnschool.be",$Suffix); $_ | Set-ADUser -UserPrincipalName $newUpn}