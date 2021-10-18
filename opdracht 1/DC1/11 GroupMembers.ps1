Import-Module ActiveDirectory
$GroupMembers = Import-Csv C:\Users\Administrator\Downloads\intranet.mijnschool.be\GroupMembers.csv -Delimiter ";"

ForEach($Mem In $GroupMembers)
{
    $Member = $Mem.Member
    $Identity = $Mem.Identity

    Write-Host "Adding $Member to $Identity" -ForegroundColor Green

    $CreateGroup = Add-ADGroupMember `
        -Identity $Identity `
        -Members $Member
}