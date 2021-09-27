$mac = "b8-e9-37-3e-55-86"


Add-DhcpServerInDC -IPAddress 192.168.1.2 -DnsName win07-dc1.intranet.mijnschool.be
Add-DhcpServerv4Scope -Name "Kortrijk" -StartRange 192.168.1.11 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -ClientId $mac -IPAddress 192.168.1.10