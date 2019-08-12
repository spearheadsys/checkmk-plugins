def perfometer_nfsiostat(row, check_command, perf_data):
    for pd in perf_data:
        if pd[0] == u'op_s':
            ops = float(pd[1])
            color = '#ff6347'
            return '%d op/s' % ops, perfometer_linear(ops, color)

perfometers["check_mk-nfsiostat"] = perfometer_nfsiostat
