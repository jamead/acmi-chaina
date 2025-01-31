create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list adc/read_adc/adc_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {eeprom/crc_check_1hz/rddata[0]} {eeprom/crc_check_1hz/rddata[1]} {eeprom/crc_check_1hz/rddata[2]} {eeprom/crc_check_1hz/rddata[3]} {eeprom/crc_check_1hz/rddata[4]} {eeprom/crc_check_1hz/rddata[5]} {eeprom/crc_check_1hz/rddata[6]} {eeprom/crc_check_1hz/rddata[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {eeprom/crc_check_1hz/bytes_read[0]} {eeprom/crc_check_1hz/bytes_read[1]} {eeprom/crc_check_1hz/bytes_read[2]} {eeprom/crc_check_1hz/bytes_read[3]} {eeprom/crc_check_1hz/bytes_read[4]} {eeprom/crc_check_1hz/bytes_read[5]} {eeprom/crc_check_1hz/bytes_read[6]} {eeprom/crc_check_1hz/bytes_read[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {eeprom/crc_check_1hz/clk_cnt[0]} {eeprom/crc_check_1hz/clk_cnt[1]} {eeprom/crc_check_1hz/clk_cnt[2]} {eeprom/crc_check_1hz/clk_cnt[3]} {eeprom/crc_check_1hz/clk_cnt[4]} {eeprom/crc_check_1hz/clk_cnt[5]} {eeprom/crc_check_1hz/clk_cnt[6]} {eeprom/crc_check_1hz/clk_cnt[7]} {eeprom/crc_check_1hz/clk_cnt[8]} {eeprom/crc_check_1hz/clk_cnt[9]} {eeprom/crc_check_1hz/clk_cnt[10]} {eeprom/crc_check_1hz/clk_cnt[11]} {eeprom/crc_check_1hz/clk_cnt[12]} {eeprom/crc_check_1hz/clk_cnt[13]} {eeprom/crc_check_1hz/clk_cnt[14]} {eeprom/crc_check_1hz/clk_cnt[15]} {eeprom/crc_check_1hz/clk_cnt[16]} {eeprom/crc_check_1hz/clk_cnt[17]} {eeprom/crc_check_1hz/clk_cnt[18]} {eeprom/crc_check_1hz/clk_cnt[19]} {eeprom/crc_check_1hz/clk_cnt[20]} {eeprom/crc_check_1hz/clk_cnt[21]} {eeprom/crc_check_1hz/clk_cnt[22]} {eeprom/crc_check_1hz/clk_cnt[23]} {eeprom/crc_check_1hz/clk_cnt[24]} {eeprom/crc_check_1hz/clk_cnt[25]} {eeprom/crc_check_1hz/clk_cnt[26]} {eeprom/crc_check_1hz/clk_cnt[27]} {eeprom/crc_check_1hz/clk_cnt[28]} {eeprom/crc_check_1hz/clk_cnt[29]} {eeprom/crc_check_1hz/clk_cnt[30]} {eeprom/crc_check_1hz/clk_cnt[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {eeprom/crc_check_1hz/crc_calc[0]} {eeprom/crc_check_1hz/crc_calc[1]} {eeprom/crc_check_1hz/crc_calc[2]} {eeprom/crc_check_1hz/crc_calc[3]} {eeprom/crc_check_1hz/crc_calc[4]} {eeprom/crc_check_1hz/crc_calc[5]} {eeprom/crc_check_1hz/crc_calc[6]} {eeprom/crc_check_1hz/crc_calc[7]} {eeprom/crc_check_1hz/crc_calc[8]} {eeprom/crc_check_1hz/crc_calc[9]} {eeprom/crc_check_1hz/crc_calc[10]} {eeprom/crc_check_1hz/crc_calc[11]} {eeprom/crc_check_1hz/crc_calc[12]} {eeprom/crc_check_1hz/crc_calc[13]} {eeprom/crc_check_1hz/crc_calc[14]} {eeprom/crc_check_1hz/crc_calc[15]} {eeprom/crc_check_1hz/crc_calc[16]} {eeprom/crc_check_1hz/crc_calc[17]} {eeprom/crc_check_1hz/crc_calc[18]} {eeprom/crc_check_1hz/crc_calc[19]} {eeprom/crc_check_1hz/crc_calc[20]} {eeprom/crc_check_1hz/crc_calc[21]} {eeprom/crc_check_1hz/crc_calc[22]} {eeprom/crc_check_1hz/crc_calc[23]} {eeprom/crc_check_1hz/crc_calc[24]} {eeprom/crc_check_1hz/crc_calc[25]} {eeprom/crc_check_1hz/crc_calc[26]} {eeprom/crc_check_1hz/crc_calc[27]} {eeprom/crc_check_1hz/crc_calc[28]} {eeprom/crc_check_1hz/crc_calc[29]} {eeprom/crc_check_1hz/crc_calc[30]} {eeprom/crc_check_1hz/crc_calc[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {eeprom/crc_check_1hz/crc_out[0]} {eeprom/crc_check_1hz/crc_out[1]} {eeprom/crc_check_1hz/crc_out[2]} {eeprom/crc_check_1hz/crc_out[3]} {eeprom/crc_check_1hz/crc_out[4]} {eeprom/crc_check_1hz/crc_out[5]} {eeprom/crc_check_1hz/crc_out[6]} {eeprom/crc_check_1hz/crc_out[7]} {eeprom/crc_check_1hz/crc_out[8]} {eeprom/crc_check_1hz/crc_out[9]} {eeprom/crc_check_1hz/crc_out[10]} {eeprom/crc_check_1hz/crc_out[11]} {eeprom/crc_check_1hz/crc_out[12]} {eeprom/crc_check_1hz/crc_out[13]} {eeprom/crc_check_1hz/crc_out[14]} {eeprom/crc_check_1hz/crc_out[15]} {eeprom/crc_check_1hz/crc_out[16]} {eeprom/crc_check_1hz/crc_out[17]} {eeprom/crc_check_1hz/crc_out[18]} {eeprom/crc_check_1hz/crc_out[19]} {eeprom/crc_check_1hz/crc_out[20]} {eeprom/crc_check_1hz/crc_out[21]} {eeprom/crc_check_1hz/crc_out[22]} {eeprom/crc_check_1hz/crc_out[23]} {eeprom/crc_check_1hz/crc_out[24]} {eeprom/crc_check_1hz/crc_out[25]} {eeprom/crc_check_1hz/crc_out[26]} {eeprom/crc_check_1hz/crc_out[27]} {eeprom/crc_check_1hz/crc_out[28]} {eeprom/crc_check_1hz/crc_out[29]} {eeprom/crc_check_1hz/crc_out[30]} {eeprom/crc_check_1hz/crc_out[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 16 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {adc_data[0]} {adc_data[1]} {adc_data[2]} {adc_data[3]} {adc_data[4]} {adc_data[5]} {adc_data[6]} {adc_data[7]} {adc_data[8]} {adc_data[9]} {adc_data[10]} {adc_data[11]} {adc_data[12]} {adc_data[13]} {adc_data[14]} {adc_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list soft_trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list eeprom/crc_check_1hz/crc_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list eeprom/crc_check_1hz/crc_rst]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list eeprom/crc_check_1hz/crc_check]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets dbg_OBUF[0]]
