# install domain controller

$DomainName = "intranet.mijnschool.be"

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Install-ADDSForest -DomainName $DomainName -InstallDN