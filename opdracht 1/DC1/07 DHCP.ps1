$mac = "b8-e9-37-3e-55-86"
$dnsName = "win07-dc1.intranet.mijnschool.be"
$dnsName2 = 

Install-WindowsFeature -Name DHCP -IncludeManagementTools

Add-DhcpServerInDC -IPAddress 192.168.1.2 -DnsName $dnsName
Add-DhcpServerv4Scope -Name "Kortrijk" -StartRange 192.168.1.11 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0
Set-DhcpServerV4OptionValue -ComputerName $dnsName  -ScopeId 192.168.1.0 -Router 192.168.1.1 -DnsServer 192.168.1.2, 192.168.1.3
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -ClientId $mac -IPAddress 192.168.1.10



