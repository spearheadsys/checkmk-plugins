# SpearHead Systems george.mocanu@sphs.ro

Import-Module RemoteDesktopServices
(cd RDS:\LicenseServer\IssuedLicenses\PerUserLicenseReports) | out-null

# Remove all old reports
Remove-Item * -Recurse

# Generate a new report
(New-Item -Name 'check' -Scope DOM) | out-null

# Total installed licenses
$total =  (Get-Item .\*\W*\InstalledCount).CurrentValue

# Total used licenses
$used = (Get-Item .\*\W*\IssuedCount).CurrentValue

# check_mk output
Write-Host "<<<rds_licenses>>>"
Write-Host "PerUserLicenses " $total " " $used
