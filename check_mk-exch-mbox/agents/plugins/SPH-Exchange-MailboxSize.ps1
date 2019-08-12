#[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
#write-output "" # workaround to prevent the byte order mark to be at the beginning of the first section
#####################################################################################
# Exchange 2010 : per user mailbox size
# Author: Marius Pana
# Company: Spearhead Systems
# Date 12/16/14
#####################################################################################

add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010

# measure time
#Measure-Command {$(Foreach ($mailbox in Get-Recipient -ResultSize Unlimited -RecipientType UserMailbox){
#$Stat = $mailbox | Get-MailboxStatistics |  Select TotalItemSize
#	New-Object PSObject -Property @{
#	PrimarySmtpAddress = $mailbox.PrimarySmtpAddress
#	TotalItemSize = $Stat.TotalItemSize.value.ToMB()
#	}
#}) | Select PrimarySmtpAddress,TotalItemSize |
#Export-CSV C:\CMK-MailboxReport.csv -NTI}

# filename for timestamp
$remote_host = $env:REMOTE_HOST
$agent_dir   = $env:MK_CONFDIR

$timestamp = $agent_dir + "\timestamp."+ $remote_host

# execute agent only every $delay seconds - 24 hours
$delay = 86400

# does $timestamp exist?
If (Test-Path $timestamp){
  # cat existing outut
  write-host "<<<exchange_user_mbx_size>>>"
  Get-Content C:\CMK-MailboxReport.csv
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

$(Foreach ($mailbox in Get-Recipient -ResultSize Unlimited -RecipientType UserMailbox){
$Stat = $mailbox | Get-MailboxStatistics |  Select TotalItemSize
	New-Object PSObject -Property @{
	PrimarySmtpAddress = $mailbox.PrimarySmtpAddress
	TotalItemSize = $Stat.TotalItemSize.value.ToMB()
	}
}) | Select PrimarySmtpAddress,TotalItemSize |
Export-CSV C:\CMK-MailboxReport.csv -NoTypeInformation

(Get-Content C:\CMK-MailboxReport.csv) | Foreach-Object {$_ -replace '"', ''} | Foreach-Object {$_ -replace ',', ' '} | select -Skip 1 | Set-Content C:\CMK-MailboxReport.csv
