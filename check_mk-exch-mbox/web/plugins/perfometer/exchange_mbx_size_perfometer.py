def perfometer_check_mk_exchange_user_mbx_size(row, check_command, perf_data):
    #return 'Hello World! :-)', '<table><tr>' \
    #    + perfometer_td(20, '#fff') \
    #    + perfometer_td(80, '#ff0000') \
    #    + '</tr></table>'
    size = float(perf_data[0][1])
    #return repr(size), ''
    color = { 0: "#68f", 1: "#ff2", 2: "#f22", 3: "#fa2" }[row["service_state"]]
    #size = perf_data[1]
    #print(size)
    return  "%.0f" % size, perfometer_logarithmic(size, 1024, 2, color)

perfometers['check_mk-exchange_user_mbx_size'] = perfometer_check_mk_exchange_user_mbx_size
