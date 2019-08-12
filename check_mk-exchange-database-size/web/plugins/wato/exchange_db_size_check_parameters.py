#!/usr/bin/python
# -*- encoding: utf-8; py-indent-offset: 4 -*-
# 2014 Marius Pana mp@sphs.ro

register_check_parameters(
    subgroup_applications,
    "exchange_db_size",
    _("MS Exchange Database Size"),
    Dictionary(
        elements = [
            ("levels", # Name of your parameters
                Tuple(
                    title = "Levels for database", # Specify a title for this parameters
                    elements = [
                        Integer(
                            title = _("Warning if above"),
                            unit = _("MB"),
                            default_value = 20000
                        ),
                        Integer(
                            title = _("Critical if above"),
                            unit = _("MB"),
                            default_value = 25000
                        ),
                    ]
                )
            ),
	],
        optional_keys = None, # Always show this subgroup
    ),
    TextAscii( title = "Name of database"),
    "dict"
)
