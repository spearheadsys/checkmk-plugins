# SpearHead Systems george.mocanu@sphs.ro
# Check for Windows 2012 Server

Import-Module RemoteDesktopServices

$path = "RDS:\LicenseServer\LicenseKeyPacks\"

Write-Host "<<<rds_licenses>>>"
foreach($pack in Get-ChildItem $path)
    {
        $checkName = $pack.Name -replace '\s',''
        $newPath = Join-Path $path $pack
        $total = (Get-Item $newPath\TotalLicenses).CurrentValue
        $usage = (Get-Item $newPath\IssuedLicensesCount).CurrentValue        
        Write-Host $checkName " " $total " " $usage
    }
exit
