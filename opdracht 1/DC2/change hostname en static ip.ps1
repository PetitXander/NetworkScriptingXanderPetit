# hostname en static ip instellen

$IP = "192.168.1.3"
$MaskBits = 24
$Gateway = "192.168.1.1"
$Dns = "192.168.1.2"
$IPType = "IPv4"
$hostname = "win07-DC2"

#
# hostname veranderen
#
Rename-Computer -NewName $hostname


#
# static ip instellen
#

# Retrieve the network adapter that you want to configure
$adapter = Get-NetAdapter | where-object {$_.PhysicalMediaType -match "802.3" -and $_.Status -eq "up"}
# Remove any existing IP, gateway from our ipv4 adapter
If (($adapter | Get-NetIPConfiguration).IPv4Address.IPAddress) {
 $adapter | Remove-NetIPAddress -AddressFamily $IPType -Confirm:$false
}
If (($adapter | Get-NetIPConfiguration).Ipv4DefaultGateway) {
 $adapter | Remove-NetRoute -AddressFamily $IPType -Confirm:$false
}
 # Configure the IP address and default gateway
$adapter | New-NetIPAddress `
 -AddressFamily $IPType `
 -IPAddress $IP `
 -PrefixLength $MaskBits `
 -DefaultGateway $Gateway
# Configure the DNS client server IP addresses
$adapter | Set-DnsClientServerAddress -ServerAddresses $DNS

#restart
Restart-Computer