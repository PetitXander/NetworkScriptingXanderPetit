$PrimaryDHCPServer = "win07-dc1.intranet.mijnschool.be"
$dnsName2 = "win07-dc2.intranet.mijnschool.be"
$scope = "192.168.1.0"


Install-WindowsFeature -Name DHCP -IncludeManagementTools
Add-DhcpServerInDC -IPAddress 192.168.1.3 -DnsName $dnsName2
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2
Add-DhcpServerv4Failover -ComputerName $PrimaryDHCPServer -Name "SFO-SIN-Failover" -PartnerServer $dnsName2 -ScopeId $scope -SharedSecret "P@ssw0rd"
Get-DhcpServerv4Failover -ComputerName $PrimaryDHCPServer 



