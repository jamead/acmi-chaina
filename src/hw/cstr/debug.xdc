create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list adc/read_adc/adc_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 17 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {calc_q/tp1/pulse_fwhm/adc_data_bs[0]} {calc_q/tp1/pulse_fwhm/adc_data_bs[1]} {calc_q/tp1/pulse_fwhm/adc_data_bs[2]} {calc_q/tp1/pulse_fwhm/adc_data_bs[3]} {calc_q/tp1/pulse_fwhm/adc_data_bs[4]} {calc_q/tp1/pulse_fwhm/adc_data_bs[5]} {calc_q/tp1/pulse_fwhm/adc_data_bs[6]} {calc_q/tp1/pulse_fwhm/adc_data_bs[7]} {calc_q/tp1/pulse_fwhm/adc_data_bs[8]} {calc_q/tp1/pulse_fwhm/adc_data_bs[9]} {calc_q/tp1/pulse_fwhm/adc_data_bs[10]} {calc_q/tp1/pulse_fwhm/adc_data_bs[11]} {calc_q/tp1/pulse_fwhm/adc_data_bs[12]} {calc_q/tp1/pulse_fwhm/adc_data_bs[13]} {calc_q/tp1/pulse_fwhm/adc_data_bs[14]} {calc_q/tp1/pulse_fwhm/adc_data_bs[15]} {calc_q/tp1/pulse_fwhm/adc_data_bs[16]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 16 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {calc_q/tp1/pulse_fwhm/adc_data[0]} {calc_q/tp1/pulse_fwhm/adc_data[1]} {calc_q/tp1/pulse_fwhm/adc_data[2]} {calc_q/tp1/pulse_fwhm/adc_data[3]} {calc_q/tp1/pulse_fwhm/adc_data[4]} {calc_q/tp1/pulse_fwhm/adc_data[5]} {calc_q/tp1/pulse_fwhm/adc_data[6]} {calc_q/tp1/pulse_fwhm/adc_data[7]} {calc_q/tp1/pulse_fwhm/adc_data[8]} {calc_q/tp1/pulse_fwhm/adc_data[9]} {calc_q/tp1/pulse_fwhm/adc_data[10]} {calc_q/tp1/pulse_fwhm/adc_data[11]} {calc_q/tp1/pulse_fwhm/adc_data[12]} {calc_q/tp1/pulse_fwhm/adc_data[13]} {calc_q/tp1/pulse_fwhm/adc_data[14]} {calc_q/tp1/pulse_fwhm/adc_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 2 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {calc_q/tp1/pulse_fwhm/state[0]} {calc_q/tp1/pulse_fwhm/state[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {adc_data[0]} {adc_data[1]} {adc_data[2]} {adc_data[3]} {adc_data[4]} {adc_data[5]} {adc_data[6]} {adc_data[7]} {adc_data[8]} {adc_data[9]} {adc_data[10]} {adc_data[11]} {adc_data[12]} {adc_data[13]} {adc_data[14]} {adc_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 17 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {calc_q/tp1/pulse_fwhm/peak[0]} {calc_q/tp1/pulse_fwhm/peak[1]} {calc_q/tp1/pulse_fwhm/peak[2]} {calc_q/tp1/pulse_fwhm/peak[3]} {calc_q/tp1/pulse_fwhm/peak[4]} {calc_q/tp1/pulse_fwhm/peak[5]} {calc_q/tp1/pulse_fwhm/peak[6]} {calc_q/tp1/pulse_fwhm/peak[7]} {calc_q/tp1/pulse_fwhm/peak[8]} {calc_q/tp1/pulse_fwhm/peak[9]} {calc_q/tp1/pulse_fwhm/peak[10]} {calc_q/tp1/pulse_fwhm/peak[11]} {calc_q/tp1/pulse_fwhm/peak[12]} {calc_q/tp1/pulse_fwhm/peak[13]} {calc_q/tp1/pulse_fwhm/peak[14]} {calc_q/tp1/pulse_fwhm/peak[15]} {calc_q/tp1/pulse_fwhm/peak[16]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 16 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {calc_q/adc_data[0]} {calc_q/adc_data[1]} {calc_q/adc_data[2]} {calc_q/adc_data[3]} {calc_q/adc_data[4]} {calc_q/adc_data[5]} {calc_q/adc_data[6]} {calc_q/adc_data[7]} {calc_q/adc_data[8]} {calc_q/adc_data[9]} {calc_q/adc_data[10]} {calc_q/adc_data[11]} {calc_q/adc_data[12]} {calc_q/adc_data[13]} {calc_q/adc_data[14]} {calc_q/adc_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 16 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {calc_q/adc_data_dly[0]} {calc_q/adc_data_dly[1]} {calc_q/adc_data_dly[2]} {calc_q/adc_data_dly[3]} {calc_q/adc_data_dly[4]} {calc_q/adc_data_dly[5]} {calc_q/adc_data_dly[6]} {calc_q/adc_data_dly[7]} {calc_q/adc_data_dly[8]} {calc_q/adc_data_dly[9]} {calc_q/adc_data_dly[10]} {calc_q/adc_data_dly[11]} {calc_q/adc_data_dly[12]} {calc_q/adc_data_dly[13]} {calc_q/adc_data_dly[14]} {calc_q/adc_data_dly[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 16 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {calc_q/adc_data_inv_dly[0]} {calc_q/adc_data_inv_dly[1]} {calc_q/adc_data_inv_dly[2]} {calc_q/adc_data_inv_dly[3]} {calc_q/adc_data_inv_dly[4]} {calc_q/adc_data_inv_dly[5]} {calc_q/adc_data_inv_dly[6]} {calc_q/adc_data_inv_dly[7]} {calc_q/adc_data_inv_dly[8]} {calc_q/adc_data_inv_dly[9]} {calc_q/adc_data_inv_dly[10]} {calc_q/adc_data_inv_dly[11]} {calc_q/adc_data_inv_dly[12]} {calc_q/adc_data_inv_dly[13]} {calc_q/adc_data_inv_dly[14]} {calc_q/adc_data_inv_dly[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 16 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {calc_q/adc_data_inv[0]} {calc_q/adc_data_inv[1]} {calc_q/adc_data_inv[2]} {calc_q/adc_data_inv[3]} {calc_q/adc_data_inv[4]} {calc_q/adc_data_inv[5]} {calc_q/adc_data_inv[6]} {calc_q/adc_data_inv[7]} {calc_q/adc_data_inv[8]} {calc_q/adc_data_inv[9]} {calc_q/adc_data_inv[10]} {calc_q/adc_data_inv[11]} {calc_q/adc_data_inv[12]} {calc_q/adc_data_inv[13]} {calc_q/adc_data_inv[14]} {calc_q/adc_data_inv[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 16 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {calc_q/tp1/pulse_fwhm/fwhm[0]} {calc_q/tp1/pulse_fwhm/fwhm[1]} {calc_q/tp1/pulse_fwhm/fwhm[2]} {calc_q/tp1/pulse_fwhm/fwhm[3]} {calc_q/tp1/pulse_fwhm/fwhm[4]} {calc_q/tp1/pulse_fwhm/fwhm[5]} {calc_q/tp1/pulse_fwhm/fwhm[6]} {calc_q/tp1/pulse_fwhm/fwhm[7]} {calc_q/tp1/pulse_fwhm/fwhm[8]} {calc_q/tp1/pulse_fwhm/fwhm[9]} {calc_q/tp1/pulse_fwhm/fwhm[10]} {calc_q/tp1/pulse_fwhm/fwhm[11]} {calc_q/tp1/pulse_fwhm/fwhm[12]} {calc_q/tp1/pulse_fwhm/fwhm[13]} {calc_q/tp1/pulse_fwhm/fwhm[14]} {calc_q/tp1/pulse_fwhm/fwhm[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 11 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {calc_q/tp1/pulse_fwhm/baseline[0]} {calc_q/tp1/pulse_fwhm/baseline[1]} {calc_q/tp1/pulse_fwhm/baseline[2]} {calc_q/tp1/pulse_fwhm/baseline[3]} {calc_q/tp1/pulse_fwhm/baseline[4]} {calc_q/tp1/pulse_fwhm/baseline[5]} {calc_q/tp1/pulse_fwhm/baseline[6]} {calc_q/tp1/pulse_fwhm/baseline[7]} {calc_q/tp1/pulse_fwhm/baseline[8]} {calc_q/tp1/pulse_fwhm/baseline[9]} {calc_q/tp1/pulse_fwhm/baseline[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list calc_q/tp1/pulse_fwhm/trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list calc_q/tp1/pulse_fwhm/fwhm_val]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list beam_detect_window]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list calc_q/tp1/pulse_fwhm/start_calc]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list beam_cycle_window]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list evr_trig]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets dbg_OBUF[0]]
