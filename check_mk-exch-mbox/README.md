check_mk-exch-mbox
==================

Check_mk check for individual exchange mailbox sizes.

title: Check for users Exchange Mailbox size
agents: windows
catalog: os/windows
license: GPL
distribution:
description:
 This check checks for individual exchange mailbox sizes.
 You need to install the plugin {SPH-Exchange-MailboxSize.ps1}
 into the {plugins} directory of your windows agent.
 This check was tested with Exchange 2010 and must have PowerShell
 installed.

 The check gets critical if there mailbox is over 2000 MB and warning
 if over 1500MB. Both are definable in Wato under "Parameters for
 Inventorized Checks", "Applications, Processes & Services".

inventory:
 One service will be created for each user mailbox where the
 {SPH-Exchange-MailboxSize.ps1} plugin produces a non-empty output.

perfdata:
 One variable: {size}: the current size of the mailbox in MB.
 
The agent uses a caching mechanism and runs once only every 24 hours.
 
#-----------------
#Quick HOWTO 
#-----------------
INSTALL PACKAGE
On your OMD/Check_mk server run the following:

 cmk -P install exchange_user_mbx_size-1.0.mkp 

The agent will be in ~/local/share/check_mk/agents/plugins/SPH-Exchange-MailboxSize.ps1

COPY AGENT TO DESTINATION
Copy the agent part (SPH-Exchange-MailboxSize.ps1) to your MS Exchange server. This
is usually in C:\Program Files\check_mk\plugins




