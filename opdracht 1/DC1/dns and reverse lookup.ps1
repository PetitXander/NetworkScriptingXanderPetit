#dns aanpassen en reverse lookup zone
$NetworkID = "192.168.1.0/24"
$ZoneFile = "1.168.192.in-addr.arpa"

$IP = "192.168.1.2"
$MaskBits = 24
$Gateway = "192.168.1.1"
$IPType = "IPv4"

$dns1 = "192.168.1.2"
$dns2 = "192.168.1.3"

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
# change dns
$adapter | set-DnsClientServerAddress -ServerAddresses ($dns1 ,$dns2)


#reverse lookup zone
Add-DnsServerPrimaryZone -NetworkID $NetworkID -ZoneFile $ZoneFile  -DynamicUpdate None -PassThru

 

