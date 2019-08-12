# check_mk-mysql_open_files

This check will monitor mysql open_files value raported to
setted open_files_limit value. The plugin must be copied
into /usr/lib/check_mk_agent/plugins folder and the
executable bit must be set for this file.

The check will return current open_files_limit and open_files
values. The check gets critical at 90 percent of
open_files_limit and warning at 80.
 
Both limits are definable in Wato under "Parameters for
Inventorized Checks", "Applications, Processes & Services".
