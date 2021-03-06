register_check_parameters(
    subgroup_storage,
    "nfsiostats",
    _("NFS IO Statistics"),
    Dictionary(
       title=_("NFS IO Statistics"),
       optional_keys=True, 
       elements=[
        ("op_s",
            Tuple(
             title=_("Operations"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="1/s"),
               Float(title=_("Critical at"), default_value=None, unit="1/s"),
            ])),
        ("rpc_backlog",
            Tuple(
             title=_("RPC Backlog"),
             elements=[
               Float(title=_("Warning below"), default_value=None, unit="queue"),
               Float(title=_("Critical below"), default_value=None, unit="queue"),
            ])),
        ("read_ops",
            Tuple(
             title=_("Read Operations /s"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="1/s"),
               Float(title=_("Critical at"), default_value=None, unit="1/s"),
            ])),
        ("read_b_s",
            Tuple(
             title=_("Reads size /s"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="bytes/s"),
               Float(title=_("Critical at"), default_value=None, unit="bytes/s"),
            ])),
        ("read_b_op",
            Tuple(
             title=_("Read bytes per operation"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="bytes/op"),
               Float(title=_("Critical at"), default_value=None, unit="bytes/op"),
            ])),
        ("read_retrans",
            Tuple(
             title=_("Read Retransmissions"),
             elements=[
               Percentage(title=_("Warning at"), default_value=None),
               Percentage(title=_("Critical at"), default_value=None),
            ])),
        ("read_avg_rtt_ms",
            Tuple(
             title=_("Read Average RTT (ms)"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="ms"),
               Float(title=_("Critical at"), default_value=None, unit="ms"),
            ])),
        ("read_avg_exe_ms",
            Tuple(
             title=_("Read Average Executions (ms)"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="ms"),
               Float(title=_("Critical at"), default_value=None, unit="ms"),
            ])),
        ("write_ops_s",
            Tuple(
             title=_("Write Operations/s"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="1/s"),
               Float(title=_("Critical at"), default_value=None, unit="1/s"),
            ])),
        ("write_b_s",
            Tuple(
             title=_("Write size /s"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="bytes/s"),
               Float(title=_("Critical at"), default_value=None, unit="bytes/s"),
            ])),
        ("write_b_op",
            Tuple(
             title=_("Write bytes per operation"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="bytes/s"),
               Float(title=_("Critical at"), default_value=None, unit="bytes/s"),
            ])),
        ("write_retrans",
            Tuple(
             title=_("Write Retransmissions"),
             elements=[
               Percentage(title=_("Warning at"), default_value=None),
               Percentage(title=_("Critical at"), default_value=None),
            ])),
        ("write_avg_rtt_ms",
            Tuple(
             title=_("Write Avg RTT (ms)"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="ms"),
               Float(title=_("Critical at"), default_value=None, unit="ms"),
            ])),
        ("write_avg_exe_ms",
            Tuple(
             title=_("Write Avg exe (ms)"),
             elements=[
               Float(title=_("Warning at"), default_value=None, unit="ms"),
               Float(title=_("Critical at"), default_value=None, unit="ms"),
            ])),
       ]
   ),

    TextAscii(
        title=_("NFS IO Statistics"),
    ),
    match_type="dict",
)