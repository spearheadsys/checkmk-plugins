#!/usr/bin/env python
# -*- encoding: utf-8; py-indent-offset: 4 -*-

group = "agents/" + _("Agent Plugins")

register_rule(group,
    "agent_config:mk_nfsiostat",
    DropdownChoice(
        title = _("NFS IO Stats (Linux)"),
        help = _("This will deploy the agent plugin <tt>mk_nfsiostat</tt> to check various client side NFS IO stats."),
        choices = [
            ( True, _("Deploy plugin for NFS IO Stats") ),
            ( None, _("Do not deploy plugin for NFS IO Stats") ),
        ]
    )
)
