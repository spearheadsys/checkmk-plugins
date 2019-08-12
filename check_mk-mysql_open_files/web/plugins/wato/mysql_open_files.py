#!/usr/bin/python
# SpearHead Syste  george.mocanu@sphs.ro  2015

register_check_parameters(
    subgroup_applications,
    "mysql_open_files",
    _("Mysql Open Files Usage Status"),
    Dictionary(
        elements = [
            ("levels", # Name of your parameters
                Tuple(
                    title = "Levels for Mysql Open Files Usage check", # Specify a title for this parameters
                    elements = [
                        Integer(
                            title = _("Warning if above"),
                            unit = _("Percent"),
                            default_value = 80
                        ),
                        Integer(
                            title = _("Critical if above"),
                            unit = _("Percent"),
                            default_value = 90
                        ),
                    ]
                )
            ),
	],
        optional_keys = None, # Always show this subgroup
    ),
    TextAscii( title = "Service name"),
    "dict"
)    
