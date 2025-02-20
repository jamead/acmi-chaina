create_clock -period 5.000 -name adc_clk -waveform {0.000 2.500} [get_ports adc_clk_p]

set_clock_groups -name adcclk_2_gtprxclk -asynchronous -group [get_clocks adc_clk] -group [get_clocks backend_gtp/kria_comm_support_i/kria_comm_init_i/U0/kria_comm_i/gt0_kria_comm_i/gtpe2_i/RXOUTCLK]
set_clock_groups -name adcclk_2_gtptxclk -asynchronous -group [get_clocks adc_clk] -group [get_clocks backend_gtp/kria_comm_support_i/kria_comm_init_i/U0/kria_comm_i/gt0_kria_comm_i/gtpe2_i/TXOUTCLK]


set _xlnx_shared_i0 [all_registers]
set_false_path -from [get_pins -hierarchical *reset*] -to $_xlnx_shared_i0

set_false_path -from [get_pins -hierarchical *accum_len*] -to $_xlnx_shared_i0
set_false_path -from [get_pins -hierarchical *accum_limit_t*] -to [all_registers]
set_false_path -from [get_pins -hierarchical *accum_limit_hr*] -to $_xlnx_shared_i0

#set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]





