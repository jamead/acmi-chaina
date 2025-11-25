create_clock -period 5.000 -name adc_clk -waveform {0.000 2.500} [get_ports adc_clk_p]

create_clock -period 100.000 -name spi_clk -waveform {0.000 50.000} [get_ports pzed_spi_sclk]

set_clock_groups -name adcclk_spiclk -asynchronous -group [get_clocks adc_clk] -group [get_clocks spi_clk]

#set _xlnx_shared_i0 [all_registers]
#set_false_path -from [get_pins -hierarchical *accum_len*] -to $_xlnx_shared_i0
#set_false_path -from [get_pins -hierarchical *accum_limit_t*] -to $_xlnx_shared_i0
#set_false_path -from [get_pins -hierarchical *accum_limit_hr*] -to $_xlnx_shared_i0

#set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]





