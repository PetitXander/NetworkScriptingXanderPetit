        $hostname = $address.HostName
        # Replace - with :
        $clientID = $address.ClientId.Replace("-",":")
        Write-Host "Hostname: $hostname, id: $clientID"
        # & to make line as command
        & $wol -v -p $port $clientID
    }
}
elseif ($filter -eq "h") {
    # Get DHCP leases
    $addresses = Get-DhcpServerv4Lease -ComputerName "DC1.intranet.mijnschool.be" -ScopeId 192.168.1.0 | select IPAddress, ClientId, HostName
    $hostname = Read-Host "Wich hosts should be waked up?"
    foreach ($address in $address) {
        $hostname = $address.HostName
        # Replace - with :
        $clientID = $address.ClientId.Replace("-",":")
        if ($hostname -ccontains $hostname) {
            Write-Host "Hostname: $hostname, id: $clientID"
            # & to make line as command
            & $wol -v -p $port $clientID
        }
    }
}
elseif ($filter -eq "m") {
    # array within Powershell
    $macs = @()
    $newMAC = Read-Host "First MAC address seperated by : (q to quit): "
    while ($newMAC -ne "q") {
     $macs += $newMAC
     $newMAC = Read-Host "Next MAC address seperated by : (q to quit): "
    }
    foreach ($mac in $macs) {
        # & to make line as command
        & $wol -v -p $port $mac
    }
}
else {
    Write-Host "Invalid option"
}