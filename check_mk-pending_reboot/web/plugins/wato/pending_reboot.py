#!/usr/bin/python
# 2015 george.mocanu@sphs.ro

register_check_parameters(
    subgroup_applications,
    "pending_reboot",
    _("Windows Pending Reboot Status"),
    Dictionary(
        elements = [
            ("levels", # Name of your parameters
                Tuple(
                    title = "Levels for pending reboot check", # Specify a title for this parameters
                    elements = [
                        Integer(
                            title = _("Warning if above"),
                            unit = _("Hours"),
                            default_value = 10
                        ),
                        Integer(
                            title = _("Critical if above"),
                            unit = _("Hours"),
                            default_value = 20
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
