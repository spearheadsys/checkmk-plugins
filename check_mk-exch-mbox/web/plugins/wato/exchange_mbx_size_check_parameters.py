#!/usr/bin/python
# -*- encoding: utf-8; py-indent-offset: 4 -*-
# 2014 Marius Pana mp@sphs.ro

register_check_parameters(
    subgroup_applications,
    "exchange_user_mbx_size",
    _("MS Exchange User Mailbox Size"),
    Dictionary(
        elements = [
            ("levels", # Name of your parameters
                Tuple(
                    title = "Levels for mailboxes", # Specify a title for this parameters
                    elements = [
                        Integer(
                            title = _("Warning if above"),
                            unit = _("MB"),
                            default_value = 1500
                        ),
                        Integer(
                            title = _("Critical if above"),
                            unit = _("MB"),
                            default_value = 2000
                        ),
                    ]
                )
            ),
        ],
        optional_keys = None, # Always show this subgroup
    ),
    TextAscii( title = "Name of mailbox"),
    "dict"
)
