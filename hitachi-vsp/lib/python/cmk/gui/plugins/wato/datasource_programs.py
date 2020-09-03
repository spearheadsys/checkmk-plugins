def _valuespec_special_agents_hitachivsp():
    return Dictionary(
        title=_("Check HITACHI VSP Storages"),
        help=_("This rule set selects the special agent for Hitachi VSP Storages "
               "instead of the normal Check_MK agent and allows monitoring via Web API. "),
        optional_keys=["cert"],
        elements=[
            ("user", TextAscii(title=_("Username"), allow_empty=False)),
            ("password", Password(title=_("Password"), allow_empty=False)),
            ("cert",
             DropdownChoice(title=_("SSL certificate verification"),
                            choices=[
                                (True, _("Activate")),
                                (False, _("Deactivate")),
                            ])),
        ],
    )


rulespec_registry.register(
    HostRulespec(
        group=RulespecGroupDatasourcePrograms,
        name="special_agents:hitachivsp",
        valuespec=_valuespec_special_agents_hitachivsp,
    ))