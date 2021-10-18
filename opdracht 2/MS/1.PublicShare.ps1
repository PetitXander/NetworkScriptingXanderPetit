$PC_Name = "Win07-MS"

#Connecting to Remote PS on DC2
$MS = New-PSSession -ComputerName $PC_Name -Credential "INTRANET\Administrator" 

 # Variables
    $Share_Name = "Public"
    $Share_Path = "C:\$Share_Name"
    $File_Path = "\\Win07-DC1\netlogon\login.bat"

    # See if our login.bat exists
    if (Test-Path $File_Path){
        Write-Host "File exists, continuing ..."
    } 
    else {
        # when logon.bat does not exist stop the script
        Write-Host "login.bat not found"
        New-Item $File_Path -ItemType File -Value "@echo off"

    }

    # See if login.bat contains "net use P: \\Win07-MS\Public"
    $Text = "net use P: \\Win07-MS\Public"

    $SEL = Select-String -Path $File_Path -Pattern $Text

    if ($SEL -ne $null)
        {
            Write-Host "Login.bat contains '$Text'"
        }
    else
        {
            Write-Host "Adding '$Text' to login.bat ..."
            Add-Content $File_Path "`nnet use P: \\Win07-MS\Public"
        }

Invoke-Command -Session $MS -ScriptBlock{

    # Variables
    $Share_Name = "Public"
    $Share_Path = "C:\$Share_Name"
    $File_Path = "\\Win07-DC1\netlogon\login.bat"

   

    # Make the directory we want to share
    mkdir $Share_Path
    
    # Share the directory, give it a name and give everyone full control
    New-SmbShare -Name $Share_Name -path $Share_Path -FullAccess Everyone

    # acl variable
    $acl = Get-ACL -Path $Share_Path

    # Disable inheritance
    $acl.SetAccessRuleProtection($True, $False)
    
    # Remove everyone from folder
    $acl.Access | %{$acl.RemoveAccessRule($_)}

    # -------------------------------------------------
    # *********************************************
    # Adding groups to share with ntfs permissions
    # *********************************************

    # Add administrators with full control
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)

    # Add system with full control
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)

    # Add Personeel Users and give them ReadAndExecute rights
    $AccessRule = new-object system.security.AccessControl.FileSystemAccessRule('Personeel','ReadAndExecute','Allow')
    $acl.AddAccessRule($AccessRule)

    # 
    # -------------------------------------------------

    # Commit everything
    Set-Acl -Path $Share_Path -AclObject $acl
}