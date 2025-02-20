


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
connect_debug_port u_ila_0/probe0 [get_nets [list {timing/fp_trig/delay[0]} {timing/fp_trig/delay[1]} {timing/fp_trig/delay[2]} {timing/fp_trig/delay[3]} {timing/fp_trig/delay[4]} {timing/fp_trig/delay[5]} {timing/fp_trig/delay[6]} {timing/fp_trig/delay[7]} {timing/fp_trig/delay[8]} {timing/fp_trig/delay[9]} {timing/fp_trig/delay[10]} {timing/fp_trig/delay[11]} {timing/fp_trig/delay[12]} {timing/fp_trig/delay[13]} {timing/fp_trig/delay[14]} {timing/fp_trig/delay[15]} {timing/fp_trig/delay[16]} {timing/fp_trig/delay[17]} {timing/fp_trig/delay[18]} {timing/fp_trig/delay[19]} {timing/fp_trig/delay[20]} {timing/fp_trig/delay[21]} {timing/fp_trig/delay[22]} {timing/fp_trig/delay[23]} {timing/fp_trig/delay[24]} {timing/fp_trig/delay[25]} {timing/fp_trig/delay[26]} {timing/fp_trig/delay[27]} {timing/fp_trig/delay[28]} {timing/fp_trig/delay[29]} {timing/fp_trig/delay[30]} {timing/fp_trig/delay[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {i2c_read/clkcnt[0]} {i2c_read/clkcnt[1]} {i2c_read/clkcnt[2]} {i2c_read/clkcnt[3]} {i2c_read/clkcnt[4]} {i2c_read/clkcnt[5]} {i2c_read/clkcnt[6]} {i2c_read/clkcnt[7]} {i2c_read/clkcnt[8]} {i2c_read/clkcnt[9]} {i2c_read/clkcnt[10]} {i2c_read/clkcnt[11]} {i2c_read/clkcnt[12]} {i2c_read/clkcnt[13]} {i2c_read/clkcnt[14]} {i2c_read/clkcnt[15]} {i2c_read/clkcnt[16]} {i2c_read/clkcnt[17]} {i2c_read/clkcnt[18]} {i2c_read/clkcnt[19]} {i2c_read/clkcnt[20]} {i2c_read/clkcnt[21]} {i2c_read/clkcnt[22]} {i2c_read/clkcnt[23]} {i2c_read/clkcnt[24]} {i2c_read/clkcnt[25]} {i2c_read/clkcnt[26]} {i2c_read/clkcnt[27]} {i2c_read/clkcnt[28]} {i2c_read/clkcnt[29]} {i2c_read/clkcnt[30]} {i2c_read/clkcnt[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 4 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {i2c_read/i2c_state[0]} {i2c_read/i2c_state[1]} {i2c_read/i2c_state[2]} {i2c_read/i2c_state[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {adc_data[0]} {adc_data[1]} {adc_data[2]} {adc_data[3]} {adc_data[4]} {adc_data[5]} {adc_data[6]} {adc_data[7]} {adc_data[8]} {adc_data[9]} {adc_data[10]} {adc_data[11]} {adc_data[12]} {adc_data[13]} {adc_data[14]} {adc_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 7 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {i2c_read/step_count[0]} {i2c_read/step_count[1]} {i2c_read/step_count[2]} {i2c_read/step_count[3]} {i2c_read/step_count[4]} {i2c_read/step_count[5]} {i2c_read/step_count[6]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 16 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {i2c_read/registers[temp1][0]} {i2c_read/registers[temp1][1]} {i2c_read/registers[temp1][2]} {i2c_read/registers[temp1][3]} {i2c_read/registers[temp1][4]} {i2c_read/registers[temp1][5]} {i2c_read/registers[temp1][6]} {i2c_read/registers[temp1][7]} {i2c_read/registers[temp1][8]} {i2c_read/registers[temp1][9]} {i2c_read/registers[temp1][10]} {i2c_read/registers[temp1][11]} {i2c_read/registers[temp1][12]} {i2c_read/registers[temp1][13]} {i2c_read/registers[temp1][14]} {i2c_read/registers[temp1][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 3 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {i2c_read/data_state[0]} {i2c_read/data_state[1]} {i2c_read/data_state[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 16 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {i2c_read/registers[Ireg0][0]} {i2c_read/registers[Ireg0][1]} {i2c_read/registers[Ireg0][2]} {i2c_read/registers[Ireg0][3]} {i2c_read/registers[Ireg0][4]} {i2c_read/registers[Ireg0][5]} {i2c_read/registers[Ireg0][6]} {i2c_read/registers[Ireg0][7]} {i2c_read/registers[Ireg0][8]} {i2c_read/registers[Ireg0][9]} {i2c_read/registers[Ireg0][10]} {i2c_read/registers[Ireg0][11]} {i2c_read/registers[Ireg0][12]} {i2c_read/registers[Ireg0][13]} {i2c_read/registers[Ireg0][14]} {i2c_read/registers[Ireg0][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 16 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {i2c_read/registers[temp0][0]} {i2c_read/registers[temp0][1]} {i2c_read/registers[temp0][2]} {i2c_read/registers[temp0][3]} {i2c_read/registers[temp0][4]} {i2c_read/registers[temp0][5]} {i2c_read/registers[temp0][6]} {i2c_read/registers[temp0][7]} {i2c_read/registers[temp0][8]} {i2c_read/registers[temp0][9]} {i2c_read/registers[temp0][10]} {i2c_read/registers[temp0][11]} {i2c_read/registers[temp0][12]} {i2c_read/registers[temp0][13]} {i2c_read/registers[temp0][14]} {i2c_read/registers[temp0][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 16 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {i2c_read/registers[Vreg0][0]} {i2c_read/registers[Vreg0][1]} {i2c_read/registers[Vreg0][2]} {i2c_read/registers[Vreg0][3]} {i2c_read/registers[Vreg0][4]} {i2c_read/registers[Vreg0][5]} {i2c_read/registers[Vreg0][6]} {i2c_read/registers[Vreg0][7]} {i2c_read/registers[Vreg0][8]} {i2c_read/registers[Vreg0][9]} {i2c_read/registers[Vreg0][10]} {i2c_read/registers[Vreg0][11]} {i2c_read/registers[Vreg0][12]} {i2c_read/registers[Vreg0][13]} {i2c_read/registers[Vreg0][14]} {i2c_read/registers[Vreg0][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list i2c_read/i2c_ready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list timing/fp_trig/gate]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list timing/fp_trig/trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list i2c_read/strobe]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets dbg_OBUF[0]]
