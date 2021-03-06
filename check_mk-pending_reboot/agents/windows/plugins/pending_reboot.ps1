#[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
## Check for pending restart status

$Computer = get-content env:computername

# Setting pending values to false to cut down on the number of else statements
$PendFileRename,$Pending,$SCCM = $false,$false,$false
# Setting CBSRebootPend to null since not all versions of Windows has this value
$CBSRebootPend = $null 
		
# Querying WMI for build version 
$WMI_OS = Get-WmiObject -Class Win32_OperatingSystem -Property BuildNumber, CSName -ComputerName $Computer -Authentication PacketPrivacy -Impersonation Impersonate

# Making registry connection to the local/remote computer 
$RegCon = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]"LocalMachine", $Computer) 
         
# If Vista/2008 & Above query the CBS Reg Key 
if ($WMI_OS.BuildNumber -ge 6001){ 
    $RegSubKeysCBS = $RegCon.OpenSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\").GetSubKeyNames() 
    $CBSRebootPend = $RegSubKeysCBS -contains "RebootPending" 
}
else{
    $CBSRebootPend = $false
}
           
# Query WUAU from the registry 
$RegWUAU = $RegCon.OpenSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\") 
$RegSubKeysWUAU = $RegWUAU.GetSubKeyNames() 
$WUAURebootReq = $RegSubKeysWUAU -contains "RebootRequired"

# Query PendingFileRenameOperations from the registry
$RegSubKeySM = $RegCon.OpenSubKey("SYSTEM\CurrentControlSet\Control\Session Manager\")
$RegValuePFRO = $RegSubKeySM.GetValue("PendingFileRenameOperations",$null)
# If PendingFileRenameOperations has a value set $RegValuePFRO variable to $true
if ($RegValuePFRO){
    $PendFileRename = $true
}


# Closing registry connection 
$RegCon.Close()

# Determine SCCM 2012 Client Reboot Pending Status
# To avoid nested 'if' statements and unneeded WMI calls to determine if the CCM_ClientUtilities class exist, setting EA = 0
$CCMClientSDK = $null
$CCMSplat = @{
    NameSpace='ROOT\ccm\ClientSDK'
    Class='CCM_ClientUtilities'
    Name='DetermineIfRebootPending'
    ComputerName=$Computer
    ErrorAction='SilentlyContinue'
    }
$CCMClientSDK = Invoke-WmiMethod @CCMSplat
if ($CCMClientSDK){
    if ($CCMClientSDK.ReturnValue -ne 0){
        Write-Warning "Error: DetermineIfRebootPending returned error code $($CCMClientSDK.ReturnValue)"
    }
    if ($CCMClientSDK.IsHardRebootPending -or $CCMClientSDK.RebootPending){
        $SCCM = $true
    }
}
else{
    $SCCM = $null
} 
		
if($CBSRebootPend –OR $WUAURebootReq -OR $PendFileRename -OR $SCCM){
    $machineNeedsRestart = $true
}
else{
    $machineNeedsRestart = $false
}
         
write-host "<<<pending_reboot>>>"

if($machineNeedsRestart){
    if(!(Test-Path "./age1.txt")){
        Get-Date -format G| Out-File ./age1.txt
        }
    $startDate=Get-Content "./age1.txt"
    $currentDate=(Get-Date -format G)
    $difference=(New-Timespan -Start $startDate -End $currentDate)
    $diffOut=[math]::round($difference.TotalHours,0)   
    write-host "pendingReboot 1"$diffOut
}
else{
    if(Test-Path "./age1.txt"){
        Remove-Item ./age1.txt
        }
    if(!(Test-Path "./age2.txt")){
        Get-Date -format G| Out-File ./age2.txt
        }
    $startDate=Get-Content "./age2.txt"
    $currentDate=(Get-Date -format G)
    $difference=(New-Timespan -Start $startDate -End $currentDate)
    $diffOut=[math]::round($difference.TotalHours,0) 
    write-host "pendingReboot 0"$diffOut     
}
