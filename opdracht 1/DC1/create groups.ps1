$groups = Import-Csv C:\Users\Administrator\Downloads\intranet.mijnschool.be\Groups.csv -Delimiter ";"


ForEach ($group In $groups)
{
    $Path = $group.Path
    $Name = $group.Name
    $Description = $group.Description
    $Displayname = $group.DisplayName
    $GroupCategory = $group.GroupCategory
    $GroupScope = $group.GroupScope


    Write-Host $Name
    Write-Host $Path
    Write-Host $Displayname

    New-ADGroup -Name $Name -Path $Path -DisplayName $Displayname -GroupCategory $GroupCategory -GroupScope $GroupScope -Description $Description -Verbose

}