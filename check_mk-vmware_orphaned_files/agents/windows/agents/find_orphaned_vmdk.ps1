# Purpose : This check verify if exists orphaned files on the datastores 
# If there are orphaned files the output will be in the following format:
# [datastore_name] File_Path/file Size Last_Modified_Time
# Modify $usr,$pwd to match your vmware infrastructure;
# Modify $delay in order to run the script at specified interval. Default is one day

Set-PSDebug -Strict

#Main
#Configure user and password and delay(in seconds)
[string]$usr = "username"
[string]$pwd = "password"
$delay = 86400


#Initialize the VIToolkit:
add-pssnapin VMware.VimAutomation.Core
[Reflection.Assembly]::LoadWithPartialName("VMware.Vim")

# filename for timestamp
$remote_host = $env:REMOTE_HOST
$agent_dir   = $env:MK_CONFDIR
$timestamp   = $agent_dir + "\timestamp."+ $remote_host

#Initialize variables
[string]$strVC = "127.0.0.1"
[string]$logfile = "C:\Orphaned_VMDK.log"
[string]$logdata = ""


# execute agent only every $delay seconds
# does $timestamp exist?
If (Test-Path $timestamp){
  # cat existing output
  Get-Content C:\Orphaned_VMDK.log
  $filedate = (ls $timestamp).LastWriteTime
  $now = Get-Date
  $earlier = $now.AddSeconds(-$delay)
  # exit if timestamp too young
  if ( $filedate -gt $earlier ) { exit }
}
# create new timestamp file
New-Item $timestamp -type file -force | Out-Null
# calculate unix timestamp
$epoch=[int][double]::Parse($(Get-Date -date (Get-Date).ToUniversalTime()-uformat %s))

[int]$countOrphaned = 0
[int64]$orphanSize = 0

# vmWare Datastore Browser query parameters
# See http://pubs.vmware.com/vi3/sdk/ReferenceGuide/vim.host.DatastoreBrowser.SearchSpec.html
$fileQueryFlags = New-Object VMware.Vim.FileQueryFlags
$fileQueryFlags.FileSize = $true
$fileQueryFlags.FileType = $true
$fileQueryFlags.Modification = $true
$searchSpec = New-Object VMware.Vim.HostDatastoreBrowserSearchSpec
$searchSpec.details = $fileQueryFlags
#The .query property is used to scope the query to only active vmdk files (excluding snaps and change block tracking).
$searchSpec.Query = (New-Object VMware.Vim.VmDiskFileQuery)
#$searchSpec.matchPattern = "*.vmdk" # Alternative VMDK match method.
$searchSpec.sortFoldersFirst = $true

if ([System.IO.File]::Exists($logfile)) {
    Remove-Item $logfile
}

#Time stamp the log file
"<<<vmware_orphaned_files>>>" | Tee-Object -Variable logdata
$logdata | Out-File -FilePath $logfile -Append

#Connect to vCenter Server
Connect-VIServer $strVC -Protocol https -User $usr -Password $pwd
#Collect array of all VMDK hard disk files in use:
[array]$UsedDisks = Get-View -ViewType VirtualMachine | % {$_.Layout} | % {$_.Disk} | % {$_.DiskFile}


#Collect array of all Datastores:
[array]$allDS = Get-Datastore | select -property name,Id | ? {$_.name -notmatch "LOG-"} | ? {$_.name -notmatch "_repository"} | Sort-Object -Property Name
[array]$orphans = @()
Foreach ($ds in $allDS) {
	$dsView = Get-View $ds.Id
	$dsBrowser = Get-View $dsView.browser
	$rootPath = "["+$dsView.summary.Name+"]"
	$searchResult = $dsBrowser.SearchDatastoreSubFolders($rootPath, $searchSpec)
	foreach ($folder in $searchResult) {
	    foreach ($fileResult in $folder.File) {
			if ($UsedDisks -notcontains ($folder.FolderPath + $fileResult.Path) -and ($fileResult.Path.length -gt 0)) {
				$orphan = New-Object System.Object
				($folder.FolderPath + $fileResult.Path) | Tee-Object -Variable orphan
				$orphans += $orphan
				([Math]::Round($fileResult.FileSize/1gb,2)) | Tee-Object -Variable orphan
				$orphans += $orphan
				([string]$fileResult.Modification.year + "-" + [string]$fileResult.Modification.month + "-" + [string]$fileResult.Modification.day) + (echo "`r`n") | Tee-Object -Variable orphan
				$orphans += $orphan
				Remove-Variable orphan
			}
		}
	}
}

[array]$orphans | Tee-Object -Variable logdata
$logdata | Out-File -FilePath $logfile -Append
Disconnect-VIServer -Confirm:$False
