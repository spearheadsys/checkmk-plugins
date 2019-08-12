metric_info['op_s'] = {
    'title': _('Operations per second'),
    'unit': 'count',
    'color': '#90ee90',
}

metric_info['rpc_backlog'] = {
    'title': _('RPC Backlog'),
    'unit': 'count',
    'color': '#90ee90',
}

metric_info['read_ops'] = {
    'title': _('Read operations'),
    'unit': '1/s',
    'color': '34/a',
}

metric_info['read_b_s'] = {
    'title': _('Read size per second'),
    'unit': 'bytes/s',
    'color': '#80ff20',
}

unit_info['bytes/op'] = {
    'title': _('Read size per operation'),
    'unit': 'bytes/op',
    'color': '#4080c0',
    "render"   : bytes_human_readable,
}

metric_info['read_b_op'] = {
    'title': _('Read size per operation'),
    'unit': 'bytes/op',
    'color': '#4080c0',
    "render"   : bytes_human_readable,
}

metric_info['read_retrans'] = {
    'title': _('Read retransmission'),
    'unit': '%',
    'color': '#90ee90',
}

metric_info['read_avg_rtt_ms'] = {
    'title': _('Read average rtt'),
    'unit': 's',
    'color': '#90ee90',
}

metric_info['read_avg_exe_ms'] = {
    'title': _('Read average exe'),
    'unit': 's',
    'color': '#90ee90',
}

metric_info['write_ops_s'] = {
    'title': _('Write operations'),
    'unit': '1/s',
    'color': '34/a',
}

metric_info['write_b_s'] = {
    'title': _('Writes size per second'),
    'unit': 'bytes/s',
    'color': '#80ff20',
}

metric_info['write_b_op'] = {
    'title': _('Writes size per operation'),
    'unit': 'bytes/op',
    'color': '#4080c0',
    "render"   : bytes_human_readable,
}

metric_info['write_avg_rtt_ms'] = {
    'title': _('Write average rtt'),
    'unit': 's',
    'color': '#90ee90',
}

metric_info['write_avg_exe_ms'] = {
    'title': _('Write average exe'),
    'unit': 's',
    'color': '#90ee90',
}