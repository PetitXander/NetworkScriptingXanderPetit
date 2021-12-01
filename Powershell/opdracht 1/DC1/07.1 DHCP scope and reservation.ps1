$mac = "b8-e9-37-3e-55-86"
$dnsName = "win07-dc1.intranet.mijnschool.be"


Add-DhcpServerInDC -IPAddress 192.168.1.2 -DnsName $dnsName
Add-DhcpServerv4Scope -Name "Kortrijk" -StartRange 192.168.1.11 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0
Set-DhcpServerV4OptionValue -ComputerName $dnsName 
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -ClientId $mac -IPAddress 192.168.1.10
Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2