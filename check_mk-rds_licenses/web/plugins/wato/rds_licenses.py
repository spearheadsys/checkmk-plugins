#!/usr/bin/python
# 2015 george.mocanu@sphs.ro
# SpearHead Systems

register_check_parameters(
    subgroup_applications,
    "rds_licenses",
    _("RDS Licenses Usage Status"),
    Dictionary(
        elements = [
            ("levels", # Name of your parameters
                Tuple(
                    title = "Levels for RDS Licenses Usage check", # Specify a title for this parameters
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
