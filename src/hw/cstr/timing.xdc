create_clock -period 5 -name adc_clk -waveform {0.000 2.500} [get_ports adc_clk_p]

create_clock -period 100 -name spi_clk -waveform {0.000 50} [get_ports pzed_spi_sclk]

set_clock_groups -name adcclk_spiclk -asynchronous -group [get_clocks adc_clk] -group [get_clocks spi_clk]

set_false_path -from [get_pins -hierarchical *accum_len*] -to [all_registers]
set_false_path -from [get_pins -hierarchical *accum_limit_t*] -to [all_registers]
set_false_path -from [get_pins -hierarchical *accum_limit_hr*] -to [all_registers]

#set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
