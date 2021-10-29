#import module niet nodige als je powershell opnieuw start na install AD
Import-Module ActiveDirectory
#cvs inlezen
$GroupMembers = Import-Csv C:\Users\Administrator\Downloads\intranet.mijnschool.be\GroupMembers.csv -Delimiter ";"

#foor loop
ForEach($Mem In $GroupMembers)
{
    $Member = $Mem.Member
    $Identity = $Mem.Identity

    Write-Host "Adding $Member to $Identity" -ForegroundColor Green

    $CreateGroup = Add-ADGroupMember `
        -Identity $Identity `
        -Members $Member
}