

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
set_property port_width 3 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {i2c_read/data_state[0]} {i2c_read/data_state[1]} {i2c_read/data_state[2]}]]
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
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {timing/fp_trig/delay[0]} {timing/fp_trig/delay[1]} {timing/fp_trig/delay[2]} {timing/fp_trig/delay[3]} {timing/fp_trig/delay[4]} {timing/fp_trig/delay[5]} {timing/fp_trig/delay[6]} {timing/fp_trig/delay[7]} {timing/fp_trig/delay[8]} {timing/fp_trig/delay[9]} {timing/fp_trig/delay[10]} {timing/fp_trig/delay[11]} {timing/fp_trig/delay[12]} {timing/fp_trig/delay[13]} {timing/fp_trig/delay[14]} {timing/fp_trig/delay[15]} {timing/fp_trig/delay[16]} {timing/fp_trig/delay[17]} {timing/fp_trig/delay[18]} {timing/fp_trig/delay[19]} {timing/fp_trig/delay[20]} {timing/fp_trig/delay[21]} {timing/fp_trig/delay[22]} {timing/fp_trig/delay[23]} {timing/fp_trig/delay[24]} {timing/fp_trig/delay[25]} {timing/fp_trig/delay[26]} {timing/fp_trig/delay[27]} {timing/fp_trig/delay[28]} {timing/fp_trig/delay[29]} {timing/fp_trig/delay[30]} {timing/fp_trig/delay[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 16 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {adc_data[0]} {adc_data[1]} {adc_data[2]} {adc_data[3]} {adc_data[4]} {adc_data[5]} {adc_data[6]} {adc_data[7]} {adc_data[8]} {adc_data[9]} {adc_data[10]} {adc_data[11]} {adc_data[12]} {adc_data[13]} {adc_data[14]} {adc_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {spi_comm/params[trig_out_delay][0]} {spi_comm/params[trig_out_delay][1]} {spi_comm/params[trig_out_delay][2]} {spi_comm/params[trig_out_delay][3]} {spi_comm/params[trig_out_delay][4]} {spi_comm/params[trig_out_delay][5]} {spi_comm/params[trig_out_delay][6]} {spi_comm/params[trig_out_delay][7]} {spi_comm/params[trig_out_delay][8]} {spi_comm/params[trig_out_delay][9]} {spi_comm/params[trig_out_delay][10]} {spi_comm/params[trig_out_delay][11]} {spi_comm/params[trig_out_delay][12]} {spi_comm/params[trig_out_delay][13]} {spi_comm/params[trig_out_delay][14]} {spi_comm/params[trig_out_delay][15]} {spi_comm/params[trig_out_delay][16]} {spi_comm/params[trig_out_delay][17]} {spi_comm/params[trig_out_delay][18]} {spi_comm/params[trig_out_delay][19]} {spi_comm/params[trig_out_delay][20]} {spi_comm/params[trig_out_delay][21]} {spi_comm/params[trig_out_delay][22]} {spi_comm/params[trig_out_delay][23]} {spi_comm/params[trig_out_delay][24]} {spi_comm/params[trig_out_delay][25]} {spi_comm/params[trig_out_delay][26]} {spi_comm/params[trig_out_delay][27]} {spi_comm/params[trig_out_delay][28]} {spi_comm/params[trig_out_delay][29]} {spi_comm/params[trig_out_delay][30]} {spi_comm/params[trig_out_delay][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 3 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {spi_comm/sync_strb[0]} {spi_comm/sync_strb[1]} {spi_comm/sync_strb[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {spi_comm/params[eeprom_wrdata][0]} {spi_comm/params[eeprom_wrdata][1]} {spi_comm/params[eeprom_wrdata][2]} {spi_comm/params[eeprom_wrdata][3]} {spi_comm/params[eeprom_wrdata][4]} {spi_comm/params[eeprom_wrdata][5]} {spi_comm/params[eeprom_wrdata][6]} {spi_comm/params[eeprom_wrdata][7]} {spi_comm/params[eeprom_wrdata][8]} {spi_comm/params[eeprom_wrdata][9]} {spi_comm/params[eeprom_wrdata][10]} {spi_comm/params[eeprom_wrdata][11]} {spi_comm/params[eeprom_wrdata][12]} {spi_comm/params[eeprom_wrdata][13]} {spi_comm/params[eeprom_wrdata][14]} {spi_comm/params[eeprom_wrdata][15]} {spi_comm/params[eeprom_wrdata][16]} {spi_comm/params[eeprom_wrdata][17]} {spi_comm/params[eeprom_wrdata][18]} {spi_comm/params[eeprom_wrdata][19]} {spi_comm/params[eeprom_wrdata][20]} {spi_comm/params[eeprom_wrdata][21]} {spi_comm/params[eeprom_wrdata][22]} {spi_comm/params[eeprom_wrdata][23]} {spi_comm/params[eeprom_wrdata][24]} {spi_comm/params[eeprom_wrdata][25]} {spi_comm/params[eeprom_wrdata][26]} {spi_comm/params[eeprom_wrdata][27]} {spi_comm/params[eeprom_wrdata][28]} {spi_comm/params[eeprom_wrdata][29]} {spi_comm/params[eeprom_wrdata][30]} {spi_comm/params[eeprom_wrdata][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 3 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {spi_comm/state[0]} {spi_comm/state[1]} {spi_comm/state[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {spi_comm/addr[0]} {spi_comm/addr[1]} {spi_comm/addr[2]} {spi_comm/addr[3]} {spi_comm/addr[4]} {spi_comm/addr[5]} {spi_comm/addr[6]} {spi_comm/addr[7]} {spi_comm/addr[8]} {spi_comm/addr[9]} {spi_comm/addr[10]} {spi_comm/addr[11]} {spi_comm/addr[12]} {spi_comm/addr[13]} {spi_comm/addr[14]} {spi_comm/addr[15]} {spi_comm/addr[16]} {spi_comm/addr[17]} {spi_comm/addr[18]} {spi_comm/addr[19]} {spi_comm/addr[20]} {spi_comm/addr[21]} {spi_comm/addr[22]} {spi_comm/addr[23]} {spi_comm/addr[24]} {spi_comm/addr[25]} {spi_comm/addr[26]} {spi_comm/addr[27]} {spi_comm/addr[28]} {spi_comm/addr[29]} {spi_comm/addr[30]} {spi_comm/addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {spi_comm/data[0]} {spi_comm/data[1]} {spi_comm/data[2]} {spi_comm/data[3]} {spi_comm/data[4]} {spi_comm/data[5]} {spi_comm/data[6]} {spi_comm/data[7]} {spi_comm/data[8]} {spi_comm/data[9]} {spi_comm/data[10]} {spi_comm/data[11]} {spi_comm/data[12]} {spi_comm/data[13]} {spi_comm/data[14]} {spi_comm/data[15]} {spi_comm/data[16]} {spi_comm/data[17]} {spi_comm/data[18]} {spi_comm/data[19]} {spi_comm/data[20]} {spi_comm/data[21]} {spi_comm/data[22]} {spi_comm/data[23]} {spi_comm/data[24]} {spi_comm/data[25]} {spi_comm/data[26]} {spi_comm/data[27]} {spi_comm/data[28]} {spi_comm/data[29]} {spi_comm/data[30]} {spi_comm/data[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 16 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {i2c_read/registers[Ireg0][0]} {i2c_read/registers[Ireg0][1]} {i2c_read/registers[Ireg0][2]} {i2c_read/registers[Ireg0][3]} {i2c_read/registers[Ireg0][4]} {i2c_read/registers[Ireg0][5]} {i2c_read/registers[Ireg0][6]} {i2c_read/registers[Ireg0][7]} {i2c_read/registers[Ireg0][8]} {i2c_read/registers[Ireg0][9]} {i2c_read/registers[Ireg0][10]} {i2c_read/registers[Ireg0][11]} {i2c_read/registers[Ireg0][12]} {i2c_read/registers[Ireg0][13]} {i2c_read/registers[Ireg0][14]} {i2c_read/registers[Ireg0][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 16 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {i2c_read/registers[Vreg4][0]} {i2c_read/registers[Vreg4][1]} {i2c_read/registers[Vreg4][2]} {i2c_read/registers[Vreg4][3]} {i2c_read/registers[Vreg4][4]} {i2c_read/registers[Vreg4][5]} {i2c_read/registers[Vreg4][6]} {i2c_read/registers[Vreg4][7]} {i2c_read/registers[Vreg4][8]} {i2c_read/registers[Vreg4][9]} {i2c_read/registers[Vreg4][10]} {i2c_read/registers[Vreg4][11]} {i2c_read/registers[Vreg4][12]} {i2c_read/registers[Vreg4][13]} {i2c_read/registers[Vreg4][14]} {i2c_read/registers[Vreg4][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 16 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {i2c_read/registers[Vreg0][0]} {i2c_read/registers[Vreg0][1]} {i2c_read/registers[Vreg0][2]} {i2c_read/registers[Vreg0][3]} {i2c_read/registers[Vreg0][4]} {i2c_read/registers[Vreg0][5]} {i2c_read/registers[Vreg0][6]} {i2c_read/registers[Vreg0][7]} {i2c_read/registers[Vreg0][8]} {i2c_read/registers[Vreg0][9]} {i2c_read/registers[Vreg0][10]} {i2c_read/registers[Vreg0][11]} {i2c_read/registers[Vreg0][12]} {i2c_read/registers[Vreg0][13]} {i2c_read/registers[Vreg0][14]} {i2c_read/registers[Vreg0][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 16 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {i2c_read/registers[Vreg6][0]} {i2c_read/registers[Vreg6][1]} {i2c_read/registers[Vreg6][2]} {i2c_read/registers[Vreg6][3]} {i2c_read/registers[Vreg6][4]} {i2c_read/registers[Vreg6][5]} {i2c_read/registers[Vreg6][6]} {i2c_read/registers[Vreg6][7]} {i2c_read/registers[Vreg6][8]} {i2c_read/registers[Vreg6][9]} {i2c_read/registers[Vreg6][10]} {i2c_read/registers[Vreg6][11]} {i2c_read/registers[Vreg6][12]} {i2c_read/registers[Vreg6][13]} {i2c_read/registers[Vreg6][14]} {i2c_read/registers[Vreg6][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 16 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {i2c_read/registers[Vreg3][0]} {i2c_read/registers[Vreg3][1]} {i2c_read/registers[Vreg3][2]} {i2c_read/registers[Vreg3][3]} {i2c_read/registers[Vreg3][4]} {i2c_read/registers[Vreg3][5]} {i2c_read/registers[Vreg3][6]} {i2c_read/registers[Vreg3][7]} {i2c_read/registers[Vreg3][8]} {i2c_read/registers[Vreg3][9]} {i2c_read/registers[Vreg3][10]} {i2c_read/registers[Vreg3][11]} {i2c_read/registers[Vreg3][12]} {i2c_read/registers[Vreg3][13]} {i2c_read/registers[Vreg3][14]} {i2c_read/registers[Vreg3][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 16 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {i2c_read/registers[Vreg1][0]} {i2c_read/registers[Vreg1][1]} {i2c_read/registers[Vreg1][2]} {i2c_read/registers[Vreg1][3]} {i2c_read/registers[Vreg1][4]} {i2c_read/registers[Vreg1][5]} {i2c_read/registers[Vreg1][6]} {i2c_read/registers[Vreg1][7]} {i2c_read/registers[Vreg1][8]} {i2c_read/registers[Vreg1][9]} {i2c_read/registers[Vreg1][10]} {i2c_read/registers[Vreg1][11]} {i2c_read/registers[Vreg1][12]} {i2c_read/registers[Vreg1][13]} {i2c_read/registers[Vreg1][14]} {i2c_read/registers[Vreg1][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 16 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {i2c_read/registers[Ireg4][0]} {i2c_read/registers[Ireg4][1]} {i2c_read/registers[Ireg4][2]} {i2c_read/registers[Ireg4][3]} {i2c_read/registers[Ireg4][4]} {i2c_read/registers[Ireg4][5]} {i2c_read/registers[Ireg4][6]} {i2c_read/registers[Ireg4][7]} {i2c_read/registers[Ireg4][8]} {i2c_read/registers[Ireg4][9]} {i2c_read/registers[Ireg4][10]} {i2c_read/registers[Ireg4][11]} {i2c_read/registers[Ireg4][12]} {i2c_read/registers[Ireg4][13]} {i2c_read/registers[Ireg4][14]} {i2c_read/registers[Ireg4][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 16 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {i2c_read/registers[Ireg2][0]} {i2c_read/registers[Ireg2][1]} {i2c_read/registers[Ireg2][2]} {i2c_read/registers[Ireg2][3]} {i2c_read/registers[Ireg2][4]} {i2c_read/registers[Ireg2][5]} {i2c_read/registers[Ireg2][6]} {i2c_read/registers[Ireg2][7]} {i2c_read/registers[Ireg2][8]} {i2c_read/registers[Ireg2][9]} {i2c_read/registers[Ireg2][10]} {i2c_read/registers[Ireg2][11]} {i2c_read/registers[Ireg2][12]} {i2c_read/registers[Ireg2][13]} {i2c_read/registers[Ireg2][14]} {i2c_read/registers[Ireg2][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 16 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {i2c_read/registers[Ireg3][0]} {i2c_read/registers[Ireg3][1]} {i2c_read/registers[Ireg3][2]} {i2c_read/registers[Ireg3][3]} {i2c_read/registers[Ireg3][4]} {i2c_read/registers[Ireg3][5]} {i2c_read/registers[Ireg3][6]} {i2c_read/registers[Ireg3][7]} {i2c_read/registers[Ireg3][8]} {i2c_read/registers[Ireg3][9]} {i2c_read/registers[Ireg3][10]} {i2c_read/registers[Ireg3][11]} {i2c_read/registers[Ireg3][12]} {i2c_read/registers[Ireg3][13]} {i2c_read/registers[Ireg3][14]} {i2c_read/registers[Ireg3][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 16 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {i2c_read/registers[Ireg6][0]} {i2c_read/registers[Ireg6][1]} {i2c_read/registers[Ireg6][2]} {i2c_read/registers[Ireg6][3]} {i2c_read/registers[Ireg6][4]} {i2c_read/registers[Ireg6][5]} {i2c_read/registers[Ireg6][6]} {i2c_read/registers[Ireg6][7]} {i2c_read/registers[Ireg6][8]} {i2c_read/registers[Ireg6][9]} {i2c_read/registers[Ireg6][10]} {i2c_read/registers[Ireg6][11]} {i2c_read/registers[Ireg6][12]} {i2c_read/registers[Ireg6][13]} {i2c_read/registers[Ireg6][14]} {i2c_read/registers[Ireg6][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 16 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list {i2c_read/registers[Ireg7][0]} {i2c_read/registers[Ireg7][1]} {i2c_read/registers[Ireg7][2]} {i2c_read/registers[Ireg7][3]} {i2c_read/registers[Ireg7][4]} {i2c_read/registers[Ireg7][5]} {i2c_read/registers[Ireg7][6]} {i2c_read/registers[Ireg7][7]} {i2c_read/registers[Ireg7][8]} {i2c_read/registers[Ireg7][9]} {i2c_read/registers[Ireg7][10]} {i2c_read/registers[Ireg7][11]} {i2c_read/registers[Ireg7][12]} {i2c_read/registers[Ireg7][13]} {i2c_read/registers[Ireg7][14]} {i2c_read/registers[Ireg7][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 16 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list {i2c_read/registers[Ireg5][0]} {i2c_read/registers[Ireg5][1]} {i2c_read/registers[Ireg5][2]} {i2c_read/registers[Ireg5][3]} {i2c_read/registers[Ireg5][4]} {i2c_read/registers[Ireg5][5]} {i2c_read/registers[Ireg5][6]} {i2c_read/registers[Ireg5][7]} {i2c_read/registers[Ireg5][8]} {i2c_read/registers[Ireg5][9]} {i2c_read/registers[Ireg5][10]} {i2c_read/registers[Ireg5][11]} {i2c_read/registers[Ireg5][12]} {i2c_read/registers[Ireg5][13]} {i2c_read/registers[Ireg5][14]} {i2c_read/registers[Ireg5][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 16 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list {i2c_read/registers[Ireg1][0]} {i2c_read/registers[Ireg1][1]} {i2c_read/registers[Ireg1][2]} {i2c_read/registers[Ireg1][3]} {i2c_read/registers[Ireg1][4]} {i2c_read/registers[Ireg1][5]} {i2c_read/registers[Ireg1][6]} {i2c_read/registers[Ireg1][7]} {i2c_read/registers[Ireg1][8]} {i2c_read/registers[Ireg1][9]} {i2c_read/registers[Ireg1][10]} {i2c_read/registers[Ireg1][11]} {i2c_read/registers[Ireg1][12]} {i2c_read/registers[Ireg1][13]} {i2c_read/registers[Ireg1][14]} {i2c_read/registers[Ireg1][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 16 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list {i2c_read/registers[Vreg2][0]} {i2c_read/registers[Vreg2][1]} {i2c_read/registers[Vreg2][2]} {i2c_read/registers[Vreg2][3]} {i2c_read/registers[Vreg2][4]} {i2c_read/registers[Vreg2][5]} {i2c_read/registers[Vreg2][6]} {i2c_read/registers[Vreg2][7]} {i2c_read/registers[Vreg2][8]} {i2c_read/registers[Vreg2][9]} {i2c_read/registers[Vreg2][10]} {i2c_read/registers[Vreg2][11]} {i2c_read/registers[Vreg2][12]} {i2c_read/registers[Vreg2][13]} {i2c_read/registers[Vreg2][14]} {i2c_read/registers[Vreg2][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 16 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list {i2c_read/registers[temp0][0]} {i2c_read/registers[temp0][1]} {i2c_read/registers[temp0][2]} {i2c_read/registers[temp0][3]} {i2c_read/registers[temp0][4]} {i2c_read/registers[temp0][5]} {i2c_read/registers[temp0][6]} {i2c_read/registers[temp0][7]} {i2c_read/registers[temp0][8]} {i2c_read/registers[temp0][9]} {i2c_read/registers[temp0][10]} {i2c_read/registers[temp0][11]} {i2c_read/registers[temp0][12]} {i2c_read/registers[temp0][13]} {i2c_read/registers[temp0][14]} {i2c_read/registers[temp0][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 16 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list {i2c_read/registers[Vreg7][0]} {i2c_read/registers[Vreg7][1]} {i2c_read/registers[Vreg7][2]} {i2c_read/registers[Vreg7][3]} {i2c_read/registers[Vreg7][4]} {i2c_read/registers[Vreg7][5]} {i2c_read/registers[Vreg7][6]} {i2c_read/registers[Vreg7][7]} {i2c_read/registers[Vreg7][8]} {i2c_read/registers[Vreg7][9]} {i2c_read/registers[Vreg7][10]} {i2c_read/registers[Vreg7][11]} {i2c_read/registers[Vreg7][12]} {i2c_read/registers[Vreg7][13]} {i2c_read/registers[Vreg7][14]} {i2c_read/registers[Vreg7][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 7 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list {i2c_read/step_count[0]} {i2c_read/step_count[1]} {i2c_read/step_count[2]} {i2c_read/step_count[3]} {i2c_read/step_count[4]} {i2c_read/step_count[5]} {i2c_read/step_count[6]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 16 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list {i2c_read/registers[temp1][0]} {i2c_read/registers[temp1][1]} {i2c_read/registers[temp1][2]} {i2c_read/registers[temp1][3]} {i2c_read/registers[temp1][4]} {i2c_read/registers[temp1][5]} {i2c_read/registers[temp1][6]} {i2c_read/registers[temp1][7]} {i2c_read/registers[temp1][8]} {i2c_read/registers[temp1][9]} {i2c_read/registers[temp1][10]} {i2c_read/registers[temp1][11]} {i2c_read/registers[temp1][12]} {i2c_read/registers[temp1][13]} {i2c_read/registers[temp1][14]} {i2c_read/registers[temp1][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 16 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list {i2c_read/registers[Vreg5][0]} {i2c_read/registers[Vreg5][1]} {i2c_read/registers[Vreg5][2]} {i2c_read/registers[Vreg5][3]} {i2c_read/registers[Vreg5][4]} {i2c_read/registers[Vreg5][5]} {i2c_read/registers[Vreg5][6]} {i2c_read/registers[Vreg5][7]} {i2c_read/registers[Vreg5][8]} {i2c_read/registers[Vreg5][9]} {i2c_read/registers[Vreg5][10]} {i2c_read/registers[Vreg5][11]} {i2c_read/registers[Vreg5][12]} {i2c_read/registers[Vreg5][13]} {i2c_read/registers[Vreg5][14]} {i2c_read/registers[Vreg5][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 16 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list {i2c_read/registers[temp3][0]} {i2c_read/registers[temp3][1]} {i2c_read/registers[temp3][2]} {i2c_read/registers[temp3][3]} {i2c_read/registers[temp3][4]} {i2c_read/registers[temp3][5]} {i2c_read/registers[temp3][6]} {i2c_read/registers[temp3][7]} {i2c_read/registers[temp3][8]} {i2c_read/registers[temp3][9]} {i2c_read/registers[temp3][10]} {i2c_read/registers[temp3][11]} {i2c_read/registers[temp3][12]} {i2c_read/registers[temp3][13]} {i2c_read/registers[temp3][14]} {i2c_read/registers[temp3][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 16 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list {i2c_read/registers[temp2][0]} {i2c_read/registers[temp2][1]} {i2c_read/registers[temp2][2]} {i2c_read/registers[temp2][3]} {i2c_read/registers[temp2][4]} {i2c_read/registers[temp2][5]} {i2c_read/registers[temp2][6]} {i2c_read/registers[temp2][7]} {i2c_read/registers[temp2][8]} {i2c_read/registers[temp2][9]} {i2c_read/registers[temp2][10]} {i2c_read/registers[temp2][11]} {i2c_read/registers[temp2][12]} {i2c_read/registers[temp2][13]} {i2c_read/registers[temp2][14]} {i2c_read/registers[temp2][15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list i2c_read/i2c_ready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list timing/fp_trig/trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list {spi_comm/params[accum_reset]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list timing/gen_tp/trig]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list {spi_comm/params[trig_out_enable]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list {spi_comm/params[eeprom_readall]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe38]
set_property port_width 1 [get_debug_ports u_ila_0/probe38]
connect_debug_port u_ila_0/probe38 [get_nets [list timing/fp_trig/gate]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe39]
set_property port_width 1 [get_debug_ports u_ila_0/probe39]
connect_debug_port u_ila_0/probe39 [get_nets [list {spi_comm/params[eeprom_trig]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe40]
set_property port_width 1 [get_debug_ports u_ila_0/probe40]
connect_debug_port u_ila_0/probe40 [get_nets [list i2c_read/strobe]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe41]
set_property port_width 1 [get_debug_ports u_ila_0/probe41]
connect_debug_port u_ila_0/probe41 [get_nets [list spi_comm/strb]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets dbg_OBUF[0]]
