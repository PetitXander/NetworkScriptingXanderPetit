# sla de file content op in een var

$FileContent = Get-ChildItem "D:\Onedrive\OneDrive - Hogeschool West-Vlaanderen\21-22 derde\Network Scripting\NetworkScriptingXanderPetit\Examen\Voor deel 1 en 2\firstrun.sh" | Get-Content

try {  


$NewFileContent = @()

#controleren als de file al aangepast is 

if ($FileContent -like "*#Start fallback preconfig*"){

        Write-Host "Firstrun is al aangepast"
 

    }

else{


#file nog niet aangepast


for ($i = 0; $i -lt $FileContent.Length; $i++) {
    #controleren als de config al is aangepast
    

    if ($FileContent[$i] -like "*rm -f /boot/firstrun.sh*") { #zoek naar de line rm -f /boot/firstrun.sh
    # zet volgende text in de nieuwe file.
    $NewFileContent += "#Start fallback preconfig
file=`"/etc/dhcpcd.conf`"
sed -i 's/#profile static_eth0/profile static/' `$file
sed -i 's/#static ip_address=192.168.1.23/static ip_address=192.168.168.168/' `$file
line=``grep -n ' # fallback to static profile' `$file | awk -F: '{ print `$1}'``
sed -i `"`$line,`$ s/#interface eth0/interface eth0/`" `$file
sed -i 's/#fallback static_eth0/arping 192.168.66.6\nfallback static_eth0/' `$file
#end fallback preconf"
    }

    $NewFileContent += $FileContent[$i]

    $NewFileContent | Out-File "D:\Onedrive\OneDrive - Hogeschool West-Vlaanderen\21-22 derde\Network Scripting\NetworkScriptingXanderPetit\Examen\Voor deel 1 en 2\firstrun.sh"


    
}

}


#$NewFileContent = $NewFileContent -replace "rm -f /boot/firstrun.sh", ""

}
catch { "An error occurred." }