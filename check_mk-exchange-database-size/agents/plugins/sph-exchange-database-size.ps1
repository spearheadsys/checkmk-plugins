#[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
#write-output "" # workaround to prevent the byte order mark to be at the
# beginning of the first section
##############################################################################
# Exchange 2010 : mail database size
# Author: Marius Pana
# Company: Spearhead Systems
# Date 12/30/14
##############################################################################

add-PSSnapin Microsoft.Exchange.Management.PowerShell.E2010

$dbs = Get-MailboxDatabase -Status | ? {$_.Mounted -eq $True} | Sort Name
ForEach ($db in $dbs) {
    $DBsize = $db.DatabaseSize.ToMB()
    $DBfreeSpace = $db.AvailableNewMailboxSpace.ToMB()
    Write-Host "<<<exchange_db_size>>>"
    Write-Host "$($db.Name) $DBsize $DBfreeSpace"
}
