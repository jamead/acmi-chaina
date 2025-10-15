create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 8192 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list adc/read_adc/adc_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {eeprom/eeprom_params[crc32_eeprom][0]} {eeprom/eeprom_params[crc32_eeprom][1]} {eeprom/eeprom_params[crc32_eeprom][2]} {eeprom/eeprom_params[crc32_eeprom][3]} {eeprom/eeprom_params[crc32_eeprom][4]} {eeprom/eeprom_params[crc32_eeprom][5]} {eeprom/eeprom_params[crc32_eeprom][6]} {eeprom/eeprom_params[crc32_eeprom][7]} {eeprom/eeprom_params[crc32_eeprom][8]} {eeprom/eeprom_params[crc32_eeprom][9]} {eeprom/eeprom_params[crc32_eeprom][10]} {eeprom/eeprom_params[crc32_eeprom][11]} {eeprom/eeprom_params[crc32_eeprom][12]} {eeprom/eeprom_params[crc32_eeprom][13]} {eeprom/eeprom_params[crc32_eeprom][14]} {eeprom/eeprom_params[crc32_eeprom][15]} {eeprom/eeprom_params[crc32_eeprom][16]} {eeprom/eeprom_params[crc32_eeprom][17]} {eeprom/eeprom_params[crc32_eeprom][18]} {eeprom/eeprom_params[crc32_eeprom][19]} {eeprom/eeprom_params[crc32_eeprom][20]} {eeprom/eeprom_params[crc32_eeprom][21]} {eeprom/eeprom_params[crc32_eeprom][22]} {eeprom/eeprom_params[crc32_eeprom][23]} {eeprom/eeprom_params[crc32_eeprom][24]} {eeprom/eeprom_params[crc32_eeprom][25]} {eeprom/eeprom_params[crc32_eeprom][26]} {eeprom/eeprom_params[crc32_eeprom][27]} {eeprom/eeprom_params[crc32_eeprom][28]} {eeprom/eeprom_params[crc32_eeprom][29]} {eeprom/eeprom_params[crc32_eeprom][30]} {eeprom/eeprom_params[crc32_eeprom][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {eeprom/eeprom_params[crc32_calc][0]} {eeprom/eeprom_params[crc32_calc][1]} {eeprom/eeprom_params[crc32_calc][2]} {eeprom/eeprom_params[crc32_calc][3]} {eeprom/eeprom_params[crc32_calc][4]} {eeprom/eeprom_params[crc32_calc][5]} {eeprom/eeprom_params[crc32_calc][6]} {eeprom/eeprom_params[crc32_calc][7]} {eeprom/eeprom_params[crc32_calc][8]} {eeprom/eeprom_params[crc32_calc][9]} {eeprom/eeprom_params[crc32_calc][10]} {eeprom/eeprom_params[crc32_calc][11]} {eeprom/eeprom_params[crc32_calc][12]} {eeprom/eeprom_params[crc32_calc][13]} {eeprom/eeprom_params[crc32_calc][14]} {eeprom/eeprom_params[crc32_calc][15]} {eeprom/eeprom_params[crc32_calc][16]} {eeprom/eeprom_params[crc32_calc][17]} {eeprom/eeprom_params[crc32_calc][18]} {eeprom/eeprom_params[crc32_calc][19]} {eeprom/eeprom_params[crc32_calc][20]} {eeprom/eeprom_params[crc32_calc][21]} {eeprom/eeprom_params[crc32_calc][22]} {eeprom/eeprom_params[crc32_calc][23]} {eeprom/eeprom_params[crc32_calc][24]} {eeprom/eeprom_params[crc32_calc][25]} {eeprom/eeprom_params[crc32_calc][26]} {eeprom/eeprom_params[crc32_calc][27]} {eeprom/eeprom_params[crc32_calc][28]} {eeprom/eeprom_params[crc32_calc][29]} {eeprom/eeprom_params[crc32_calc][30]} {eeprom/eeprom_params[crc32_calc][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 16 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {adc/read_adc/adc_data[0]} {adc/read_adc/adc_data[1]} {adc/read_adc/adc_data[2]} {adc/read_adc/adc_data[3]} {adc/read_adc/adc_data[4]} {adc/read_adc/adc_data[5]} {adc/read_adc/adc_data[6]} {adc/read_adc/adc_data[7]} {adc/read_adc/adc_data[8]} {adc/read_adc/adc_data[9]} {adc/read_adc/adc_data[10]} {adc/read_adc/adc_data[11]} {adc/read_adc/adc_data[12]} {adc/read_adc/adc_data[13]} {adc/read_adc/adc_data[14]} {adc/read_adc/adc_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list acis_keylock_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list eeprom/xfer_done]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list gen_faults/fault_bad_limit]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list eeprom/acis_keylock_prev]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list eeprom/acis_keylock]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list timing/fiber_trig_fp]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list timing/ext_trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list timing/fp_trig_out]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets dbg_OBUF[0]]
