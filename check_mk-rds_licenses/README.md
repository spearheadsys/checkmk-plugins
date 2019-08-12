# check_mk-rds_licenses
Monitor per user RDS licenses usage.

The check for rds licenses usage is based on folowing plugins:
        - rds_licenses_2008.ps1
        - rds_licenses_2012.ps1
        - elevate_shell.ps1
If the Windows Server is 64 bit version the agent for x64 must be installed.

Install procedure:
        On Windows 2008 Server: copy the rds_licenses_2008.ps1 file in plugins
directory of check_mk agent folder.
        On Windows 2012 Server: copy the elevate_shell.ps1 into plugins directory
of check_mk agent folder and the rds_licenses_2012.ps1 into check_mk agent folder.
The elevate_shell.ps1 will elevate de privileges for running rds_licences_2012.ps1
and the user which run check_mk agent must have the rights to "run as 
administrator".
