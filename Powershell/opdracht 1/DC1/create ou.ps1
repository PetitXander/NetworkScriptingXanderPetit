#delimiter niet vergeten
$OUs = Import-Csv C:\Users\Administrator\Downloads\intranet.mijnschool.be\OUs.csv -Delimiter ";"


ForEach ($OU In $OUs)
{
    $Name = $OU.Name
    $Path = $OU.Path
    $Description = $OU.Description
    $Displayname = $OU."Display Name"

    Write-Host $Name
    Write-Host $Path
    Write-Host $Displayname

    New-ADOrganizationalUnit -Name $Name -Path $Path -DisplayName $Displayname -ProtectedFromAccidentalDeletion $False -Description $Description -Server "win07-DC1.intranet.mijnschool.be" -Verbose

}