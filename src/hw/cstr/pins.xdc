
# ltc2107 adc
set_property PACKAGE_PIN V4 [get_ports adc_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports adc_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports adc_clk_n]
set_property DIFF_TERM TRUE [get_ports adc_clk_p]
set_property DIFF_TERM TRUE [get_ports adc_clk_n]

set_property PACKAGE_PIN T1 [get_ports {adc_data_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_p[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_n[0]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_p[0]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_n[0]}]

set_property PACKAGE_PIN R3 [get_ports {adc_data_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_p[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_n[1]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_p[1]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_n[1]}]

set_property PACKAGE_PIN W1 [get_ports {adc_data_p[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_p[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_n[2]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_p[2]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_n[2]}]

set_property PACKAGE_PIN U2 [get_ports {adc_data_p[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_p[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_n[3]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_p[3]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_n[3]}]

set_property PACKAGE_PIN U3 [get_ports {adc_data_p[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_p[4]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_n[4]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_p[4]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_n[4]}]

set_property PACKAGE_PIN W2 [get_ports {adc_data_p[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_p[5]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_n[5]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_p[5]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_n[5]}]

set_property PACKAGE_PIN Y3 [get_ports {adc_data_p[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_p[6]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_n[6]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_p[6]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_n[6]}]

set_property PACKAGE_PIN AB3 [get_ports {adc_data_p[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_p[7]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_data_n[7]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_p[7]}]
set_property DIFF_TERM TRUE [get_ports {adc_data_n[7]}]

set_property PACKAGE_PIN Y4 [get_ports adc_of_p]
set_property IOSTANDARD LVDS_25 [get_ports adc_of_p]
set_property IOSTANDARD LVDS_25 [get_ports adc_of_n]
set_property DIFF_TERM TRUE [get_ports adc_of_p]
set_property DIFF_TERM TRUE [get_ports adc_of_n]


set_property PACKAGE_PIN AB16 [get_ports adc_spi_cs]
set_property IOSTANDARD LVCMOS33 [get_ports adc_spi_cs]
set_property DRIVE 12 [get_ports adc_spi_cs]
set_property SLEW SLOW [get_ports adc_spi_cs]

set_property PACKAGE_PIN AB17 [get_ports adc_spi_sck]
set_property IOSTANDARD LVCMOS33 [get_ports adc_spi_sck]
set_property DRIVE 12 [get_ports adc_spi_sck]
set_property SLEW SLOW [get_ports adc_spi_sck]

set_property PACKAGE_PIN Y16 [get_ports adc_spi_sdi]
set_property IOSTANDARD LVCMOS33 [get_ports adc_spi_sdi]
set_property DRIVE 12 [get_ports adc_spi_sdi]
set_property SLEW SLOW [get_ports adc_spi_sdi]

set_property PACKAGE_PIN AA16 [get_ports adc_spi_sdo]
set_property IOSTANDARD LVCMOS33 [get_ports adc_spi_sdo]
set_property PULLUP true [get_ports adc_spi_sdo]


# trigger input and outputs
#set_property PACKAGE_PIN N17 [get_ports fiber_trig_in]
#set_property IOSTANDARD LVCMOS33 [get_ports fiber_trig_in]
#set_property DRIVE 12 [get_ports fiber_trig_in]
#set_property SLEW FAST [get_ports fiber_trig_in]

set_property PACKAGE_PIN P15 [get_ports fiber_trig_led]
set_property IOSTANDARD LVCMOS33 [get_ports fiber_trig_led]
set_property DRIVE 12 [get_ports fiber_trig_led]
set_property SLEW FAST [get_ports fiber_trig_led]

set_property PACKAGE_PIN R16 [get_ports fiber_trig_fp]
set_property IOSTANDARD LVCMOS33 [get_ports fiber_trig_fp]
set_property DRIVE 12 [get_ports fiber_trig_fp]
set_property SLEW FAST [get_ports fiber_trig_fp]



# eeprom 0
set_property PACKAGE_PIN B1 [get_ports eeprom_csn]
set_property IOSTANDARD LVCMOS33 [get_ports eeprom_csn]
set_property DRIVE 12 [get_ports eeprom_csn]
set_property SLEW FAST [get_ports eeprom_csn]

set_property PACKAGE_PIN A1 [get_ports eeprom_sck]
set_property IOSTANDARD LVCMOS33 [get_ports eeprom_sck]
set_property DRIVE 12 [get_ports eeprom_sck]
set_property SLEW FAST [get_ports eeprom_sck]

set_property PACKAGE_PIN C2 [get_ports eeprom_sdi]
set_property IOSTANDARD LVCMOS33 [get_ports eeprom_sdi]
set_property DRIVE 12 [get_ports eeprom_sdi]
set_property SLEW FAST [get_ports eeprom_sdi]

set_property PACKAGE_PIN E1 [get_ports eeprom_sdo]
set_property IOSTANDARD LVCMOS33 [get_ports eeprom_sdo]

set_property PACKAGE_PIN B2 [get_ports eeprom_holdn]
set_property IOSTANDARD LVCMOS33 [get_ports eeprom_holdn]
set_property DRIVE 12 [get_ports eeprom_holdn]
set_property SLEW FAST [get_ports eeprom_holdn]



# front panel led
set_property PACKAGE_PIN P17 [get_ports keylock_detect_led]
set_property IOSTANDARD LVCMOS33 [get_ports keylock_detect_led]
set_property DRIVE 12 [get_ports keylock_detect_led]
set_property SLEW FAST [get_ports keylock_detect_led]




# tp pulses (to Tony's test pulse generation board)
#tpdac_sdin on schematic  (sw1)
set_property PACKAGE_PIN R1 [get_ports {tp_pulse[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tp_pulse[0]}]
set_property DRIVE 12 [get_ports {tp_pulse[0]}]
set_property SLEW FAST [get_ports {tp_pulse[0]}]

#tpdac_sclk on schematic  (sw2)
set_property PACKAGE_PIN P4 [get_ports {tp_pulse[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tp_pulse[1]}]
set_property DRIVE 12 [get_ports {tp_pulse[1]}]
set_property SLEW FAST [get_ports {tp_pulse[1]}]

#tpdac_syncn on schematic (sw3)
set_property PACKAGE_PIN P2 [get_ports {tp_pulse[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tp_pulse[2]}]
set_property DRIVE 12 [get_ports {tp_pulse[2]}]
set_property SLEW FAST [get_ports {tp_pulse[2]}]

#tpdac_ldacn on schematic  (sw4)
set_property PACKAGE_PIN P1 [get_ports {tp_pulse[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tp_pulse[3]}]
set_property DRIVE 12 [get_ports {tp_pulse[3]}]
set_property SLEW FAST [get_ports {tp_pulse[3]}]

#tpdac_clrn on schematic (a0)
set_property PACKAGE_PIN N5 [get_ports {tp_pulse[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tp_pulse[4]}]
set_property DRIVE 12 [get_ports {tp_pulse[4]}]
set_property SLEW FAST [get_ports {tp_pulse[4]}]

#tpdac_sdo on schematic  (a1)
set_property PACKAGE_PIN N4 [get_ports {tp_pulse[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tp_pulse[5]}]
set_property DRIVE 12 [get_ports {tp_pulse[5]}]
set_property SLEW FAST [get_ports {tp_pulse[5]}]

#tp_sw0 on schematic  (en)
set_property PACKAGE_PIN N3 [get_ports {tp_pulse[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tp_pulse[6]}]
set_property DRIVE 12 [get_ports {tp_pulse[6]}]
set_property SLEW FAST [get_ports {tp_pulse[6]}]

#tp_sw1 on schematic (nc)
set_property PACKAGE_PIN N2 [get_ports {tp_pulse[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tp_pulse[7]}]
set_property DRIVE 12 [get_ports {tp_pulse[7]}]
set_property SLEW FAST [get_ports {tp_pulse[7]}]






#picozed to artix spi
#set_property PACKAGE_PIN D21 [get_ports pzed_spi_dout]
#set_property IOSTANDARD LVCMOS33 [get_ports pzed_spi_dout]


#set_property PACKAGE_PIN E22 [get_ports pzed_spi_din]
#set_property IOSTANDARD LVCMOS33 [get_ports pzed_spi_din]
#set_property DRIVE 12 [get_ports pzed_spi_din]
#set_property SLEW FAST [get_ports pzed_spi_din]

#set_property PACKAGE_PIN D17 [get_ports pzed_spi_sclk]
#set_property IOSTANDARD LVCMOS33 [get_ports pzed_spi_sclk]

#set_property PACKAGE_PIN E21 [get_ports pzed_spi_cs]
#set_property IOSTANDARD LVCMOS33 [get_ports pzed_spi_cs]





# debug leds
set_property PACKAGE_PIN D15 [get_ports {dbg_leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg_leds[0]}]
set_property DRIVE 12 [get_ports {dbg_leds[0]}]
set_property SLEW FAST [get_ports {dbg_leds[0]}]

set_property PACKAGE_PIN B15 [get_ports {dbg_leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg_leds[1]}]
set_property DRIVE 12 [get_ports {dbg_leds[1]}]
set_property SLEW FAST [get_ports {dbg_leds[1]}]

set_property PACKAGE_PIN B16 [get_ports {dbg_leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg_leds[2]}]
set_property DRIVE 12 [get_ports {dbg_leds[2]}]
set_property SLEW FAST [get_ports {dbg_leds[2]}]

set_property PACKAGE_PIN C13 [get_ports {dbg_leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg_leds[3]}]
set_property DRIVE 12 [get_ports {dbg_leds[3]}]
set_property SLEW FAST [get_ports {dbg_leds[3]}]




# debug header
set_property PACKAGE_PIN F15 [get_ports {dbg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[0]}]
set_property DRIVE 12 [get_ports {dbg[0]}]
set_property SLEW FAST [get_ports {dbg[0]}]

set_property PACKAGE_PIN F13 [get_ports {dbg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[1]}]
set_property DRIVE 12 [get_ports {dbg[1]}]
set_property SLEW FAST [get_ports {dbg[1]}]

set_property PACKAGE_PIN F14 [get_ports {dbg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[2]}]
set_property DRIVE 12 [get_ports {dbg[2]}]
set_property SLEW FAST [get_ports {dbg[2]}]

set_property PACKAGE_PIN F16 [get_ports {dbg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[3]}]
set_property DRIVE 12 [get_ports {dbg[3]}]
set_property SLEW FAST [get_ports {dbg[3]}]

set_property PACKAGE_PIN E17 [get_ports {dbg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[4]}]
set_property DRIVE 12 [get_ports {dbg[4]}]
set_property SLEW FAST [get_ports {dbg[4]}]

set_property PACKAGE_PIN C14 [get_ports {dbg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[5]}]
set_property DRIVE 12 [get_ports {dbg[5]}]
set_property SLEW FAST [get_ports {dbg[5]}]

set_property PACKAGE_PIN C15 [get_ports {dbg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[6]}]
set_property DRIVE 12 [get_ports {dbg[6]}]
set_property SLEW FAST [get_ports {dbg[6]}]

set_property PACKAGE_PIN E13 [get_ports {dbg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[7]}]
set_property DRIVE 12 [get_ports {dbg[7]}]
set_property SLEW FAST [get_ports {dbg[7]}]

set_property PACKAGE_PIN E14 [get_ports {dbg[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[8]}]
set_property DRIVE 12 [get_ports {dbg[8]}]
set_property SLEW FAST [get_ports {dbg[8]}]

set_property PACKAGE_PIN E16 [get_ports {dbg[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg[9]}]
set_property DRIVE 12 [get_ports {dbg[9]}]
set_property SLEW FAST [get_ports {dbg[9]}]


# test pulse dac
#set_property PACKAGE_PIN G3 [get_ports {dac_tp_data[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[0]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[0]}]
#set_property SLEW FAST [get_ports {dac_tp_data[0]}]

#set_property PACKAGE_PIN G2 [get_ports {dac_tp_data[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[1]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[1]}]
#set_property SLEW FAST [get_ports {dac_tp_data[1]}]

#set_property PACKAGE_PIN H3 [get_ports {dac_tp_data[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[2]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[2]}]
#set_property SLEW FAST [get_ports {dac_tp_data[2]}]

#set_property PACKAGE_PIN H2 [get_ports {dac_tp_data[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[3]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[3]}]
#set_property SLEW FAST [get_ports {dac_tp_data[3]}]

#set_property PACKAGE_PIN J2 [get_ports {dac_tp_data[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[4]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[4]}]
#set_property SLEW FAST [get_ports {dac_tp_data[4]}]

#set_property PACKAGE_PIN J1 [get_ports {dac_tp_data[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[5]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[5]}]
#set_property SLEW FAST [get_ports {dac_tp_data[5]}]

#set_property PACKAGE_PIN K3 [get_ports {dac_tp_data[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[6]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[6]}]
#set_property SLEW FAST [get_ports {dac_tp_data[6]}]

#set_property PACKAGE_PIN K2 [get_ports {dac_tp_data[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[7]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[7]}]
#set_property SLEW FAST [get_ports {dac_tp_data[7]}]

#set_property PACKAGE_PIN K1 [get_ports {dac_tp_data[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[8]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[8]}]
#set_property SLEW FAST [get_ports {dac_tp_data[8]}]

#set_property PACKAGE_PIN L1 [get_ports {dac_tp_data[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[9]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[9]}]
#set_property SLEW FAST [get_ports {dac_tp_data[9]}]

#set_property PACKAGE_PIN L3 [get_ports {dac_tp_data[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[10]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[10]}]
#set_property SLEW FAST [get_ports {dac_tp_data[10]}]

#set_property PACKAGE_PIN M3 [get_ports {dac_tp_data[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[11]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[11]}]
#set_property SLEW FAST [get_ports {dac_tp_data[11]}]

#set_property PACKAGE_PIN M2 [get_ports {dac_tp_data[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[12]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[12]}]
#set_property SLEW FAST [get_ports {dac_tp_data[12]}]

#set_property PACKAGE_PIN L4 [get_ports {dac_tp_data[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_tp_data[13]}]
#set_property DRIVE 12 [get_ports {dac_tp_data[13]}]
#set_property SLEW FAST [get_ports {dac_tp_data[13]}]

#set_property PACKAGE_PIN M1 [get_ports dac_tp_clk]
#set_property IOSTANDARD LVCMOS33 [get_ports dac_tp_clk]
#set_property DRIVE 12 [get_ports dac_tp_clk]
#set_property SLEW FAST [get_ports dac_tp_clk]


# front panel test port dac
#set_property PACKAGE_PIN D20 [get_ports {dac_fp_data[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[0]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[0]}]
#set_property SLEW FAST [get_ports {dac_fp_data[0]}]

#set_property PACKAGE_PIN D19 [get_ports {dac_fp_data[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[1]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[1]}]
#set_property SLEW FAST [get_ports {dac_fp_data[1]}]

#set_property PACKAGE_PIN C22 [get_ports {dac_fp_data[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[2]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[2]}]
#set_property SLEW FAST [get_ports {dac_fp_data[2]}]

#set_property PACKAGE_PIN C20 [get_ports {dac_fp_data[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[3]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[3]}]
#set_property SLEW FAST [get_ports {dac_fp_data[3]}]

#set_property PACKAGE_PIN C19 [get_ports {dac_fp_data[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[4]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[4]}]
#set_property SLEW FAST [get_ports {dac_fp_data[4]}]

#set_property PACKAGE_PIN C18 [get_ports {dac_fp_data[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[5]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[5]}]
#set_property SLEW FAST [get_ports {dac_fp_data[5]}]

#set_property PACKAGE_PIN E19 [get_ports {dac_fp_data[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[6]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[6]}]
#set_property SLEW FAST [get_ports {dac_fp_data[6]}]

#set_property PACKAGE_PIN B21 [get_ports {dac_fp_data[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[7]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[7]}]
#set_property SLEW FAST [get_ports {dac_fp_data[7]}]

#set_property PACKAGE_PIN B20 [get_ports {dac_fp_data[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[8]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[8]}]
#set_property SLEW FAST [get_ports {dac_fp_data[8]}]

#set_property PACKAGE_PIN B18 [get_ports {dac_fp_data[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[9]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[9]}]
#set_property SLEW FAST [get_ports {dac_fp_data[9]}]

#set_property PACKAGE_PIN B17 [get_ports {dac_fp_data[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[10]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[10]}]
#set_property SLEW FAST [get_ports {dac_fp_data[10]}]

#set_property PACKAGE_PIN B22 [get_ports {dac_fp_data[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[11]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[11]}]
#set_property SLEW FAST [get_ports {dac_fp_data[11]}]

#set_property PACKAGE_PIN A20 [get_ports {dac_fp_data[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[12]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[12]}]
#set_property SLEW FAST [get_ports {dac_fp_data[12]}]

#set_property PACKAGE_PIN A19 [get_ports {dac_fp_data[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dac_fp_data[13]}]
#set_property DRIVE 12 [get_ports {dac_fp_data[13]}]
#set_property SLEW FAST [get_ports {dac_fp_data[13]}]

#set_property PACKAGE_PIN A21 [get_ports dac_fp_clk]
#set_property IOSTANDARD LVCMOS33 [get_ports dac_fp_clk]
#set_property DRIVE 12 [get_ports dac_fp_clk]
#set_property SLEW FAST [get_ports dac_fp_clk]



#watchdog_clock
set_property PACKAGE_PIN A13 [get_ports watchdog_clock]
set_property IOSTANDARD LVCMOS33 [get_ports watchdog_clock]

#watchdog_pulse
set_property PACKAGE_PIN A16 [get_ports watchdog_pulse]
set_property IOSTANDARD LVCMOS33 [get_ports watchdog_pulse]


#fault_bad_power
set_property PACKAGE_PIN AB22 [get_ports fault_bad_power]
set_property IOSTANDARD LVCMOS33 [get_ports fault_bad_power]

#fault_no_trig (from MAX815)
set_property PACKAGE_PIN V17 [get_ports fault_no_trigger]
set_property IOSTANDARD LVCMOS33 [get_ports fault_no_trigger]

#fault_no_pulse (from MAX815)
set_property PACKAGE_PIN R14 [get_ports fault_no_pulse]
set_property IOSTANDARD LVCMOS33 [get_ports fault_no_pulse]

#fault_no_clock (from MAX815)
set_property PACKAGE_PIN AB20 [get_ports fault_no_clock]
set_property IOSTANDARD LVCMOS33 [get_ports fault_no_clock]



# fault outputs
set_property PACKAGE_PIN V19 [get_ports {faultsn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[0]}]
set_property DRIVE 12 [get_ports {faultsn[0]}]
set_property SLEW FAST [get_ports {faultsn[0]}]

set_property PACKAGE_PIN AA19 [get_ports {faultsn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[1]}]
set_property DRIVE 12 [get_ports {faultsn[1]}]
set_property SLEW FAST [get_ports {faultsn[1]}]

set_property PACKAGE_PIN AA18 [get_ports {faultsn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[2]}]
set_property DRIVE 12 [get_ports {faultsn[2]}]
set_property SLEW FAST [get_ports {faultsn[2]}]

set_property PACKAGE_PIN V18 [get_ports {faultsn[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[3]}]
set_property DRIVE 12 [get_ports {faultsn[3]}]
set_property SLEW FAST [get_ports {faultsn[3]}]

set_property PACKAGE_PIN R18 [get_ports {faultsn[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[4]}]
set_property DRIVE 12 [get_ports {faultsn[4]}]
set_property SLEW FAST [get_ports {faultsn[4]}]

set_property PACKAGE_PIN U20 [get_ports {faultsn[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[5]}]
set_property DRIVE 12 [get_ports {faultsn[5]}]
set_property SLEW FAST [get_ports {faultsn[5]}]

set_property PACKAGE_PIN V20 [get_ports {faultsn[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[6]}]
set_property DRIVE 12 [get_ports {faultsn[6]}]
set_property SLEW FAST [get_ports {faultsn[6]}]

set_property PACKAGE_PIN V22 [get_ports {faultsn[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[7]}]
set_property DRIVE 12 [get_ports {faultsn[7]}]
set_property SLEW FAST [get_ports {faultsn[7]}]

set_property PACKAGE_PIN P19 [get_ports {faultsn[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[8]}]
set_property DRIVE 12 [get_ports {faultsn[8]}]
set_property SLEW FAST [get_ports {faultsn[8]}]

set_property PACKAGE_PIN U21 [get_ports {faultsn[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[9]}]
set_property DRIVE 12 [get_ports {faultsn[9]}]
set_property SLEW FAST [get_ports {faultsn[9]}]

set_property PACKAGE_PIN W21 [get_ports {faultsn[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[10]}]
set_property DRIVE 12 [get_ports {faultsn[10]}]
set_property SLEW FAST [get_ports {faultsn[10]}]

set_property PACKAGE_PIN AA21 [get_ports {faultsn[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faultsn[11]}]
set_property DRIVE 12 [get_ports {faultsn[11]}]
set_property SLEW FAST [get_ports {faultsn[11]}]





# fault latched inputs

## fault_beam_high latched  (fault_fpga_11_lat)
#set_property PACKAGE_PIN AB21 [get_ports {faults_lat[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[0]}]

##fault_bunch_limit_lat (fault_fpga_10_lat)
#set_property PACKAGE_PIN Y21 [get_ports {faults_lat[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[1]}]

##fault_no_trigger_lat  (fault_no_trig_lat)
#set_property PACKAGE_PIN W17 [get_ports {faults_lat[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[2]}]

##fault_no_clock_lat (fault_no_clock_lat)
#set_property PACKAGE_PIN AA20 [get_ports {faults_lat[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[3]}]

##fault_base_integrity (fault_fpga_9_lat)
#set_property PACKAGE_PIN T21 [get_ports {faults_lat[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[4]}]

##fault_tp1_lat  (fault_fpga_8_lat)
#set_property PACKAGE_PIN R19 [get_ports {faults_lat[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[5]}]

##fault_tp2_lat  (fault_fpga_4_lat)
#set_property PACKAGE_PIN N13 [get_ports {faults_lat[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[6]}]

##fault_tp3_lat (fault_fpga_3_lat)
#set_property PACKAGE_PIN U18 [get_ports {faults_lat[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[7]}]

##fault_bad_limit_lat  (fault_fpga_2_lat)
#set_property PACKAGE_PIN Y18 [get_ports {faults_lat[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[8]}]

##fault_adc_sat  (fault_fpga_7_lat)
#set_property PACKAGE_PIN W22 [get_ports {faults_lat[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[9]}]

##fault_bad_power  (fault_bad_power_lat)
#set_property PACKAGE_PIN Y22 [get_ports {faults_lat[10]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[10]}]

##fault_beam_out_of_window_lat  (fault_fpga_1_lat)
#set_property PACKAGE_PIN AB18 [get_ports {faults_lat[11]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[11]}]

##fault_acis_keylock  (fault_fpga_6_lat)
#set_property PACKAGE_PIN W20 [get_ports {faults_lat[12]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[12]}]

##fault_reserved (fault_fpga_5_lat)
#set_property PACKAGE_PIN T20 [get_ports {faults_lat[13]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[13]}]

##fault_reserved (fault_fpga_0_lat)
#set_property PACKAGE_PIN Y19 [get_ports {faults_lat[14]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[14]}]

##fault_reserved  (fault_no_pulse_lat)
#set_property PACKAGE_PIN P14 [get_ports {faults_lat[15]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[15]}]


# fault latched inputs



# fault_beam_high latched  (fault_fpga_11_lat)

set_property PACKAGE_PIN AB21 [get_ports {faults_lat[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[0]}]

#fault_bunch_limit_lat (fault_fpga_10_lat)
set_property PACKAGE_PIN Y21 [get_ports {faults_lat[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[1]}]

#fault_base_integrity (fault_fpga_9_lat)
set_property PACKAGE_PIN T21 [get_ports {faults_lat[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[2]}]

#fault_tp1_lat  (fault_fpga_8_lat)
set_property PACKAGE_PIN R19 [get_ports {faults_lat[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[3]}]

#fault_tp2_lat  (fault_fpga_4_lat)
set_property PACKAGE_PIN N13 [get_ports {faults_lat[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[4]}]

#fault_tp3_lat (fault_fpga_3_lat)
set_property PACKAGE_PIN U18 [get_ports {faults_lat[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[5]}]

#fault_bad_limit_lat  (fault_fpga_2_lat)
set_property PACKAGE_PIN Y18 [get_ports {faults_lat[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[6]}]

#fault_beam_out_of_window_lat  (fault_fpga_1_lat)
set_property PACKAGE_PIN AB18 [get_ports {faults_lat[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[7]}]

#fault_bad_power  (fault_bad_power_lat)
set_property PACKAGE_PIN Y22 [get_ports {faults_lat[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[8]}]

#fault_adc_sat  (fault_fpga_7_lat)
set_property PACKAGE_PIN W22 [get_ports {faults_lat[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[9]}]

#fault_acis_keylock  (fault_fpga_6_lat)
set_property PACKAGE_PIN W20 [get_ports {faults_lat[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[10]}]

#fault_reserved (fault_fpga_5_lat)
set_property PACKAGE_PIN T20 [get_ports {faults_lat[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[11]}]

#fault_reserved (fault_fpga_0_lat)
set_property PACKAGE_PIN Y19 [get_ports {faults_lat[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[12]}]

#fault_no_clock_lat (fault_no_clock_lat)
set_property PACKAGE_PIN AA20 [get_ports {faults_lat[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[13]}]

#fault_reserved  (fault_no_pulse_lat)
set_property PACKAGE_PIN P14 [get_ports {faults_lat[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[14]}]

#fault_no_trigger_lat  (fault_no_trig_lat)
set_property PACKAGE_PIN W17 [get_ports {faults_lat[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {faults_lat[15]}]





#acis_faultn
set_property PACKAGE_PIN N14 [get_ports acis_faultn]
set_property IOSTANDARD LVCMOS33 [get_ports acis_faultn]

#acis_fault_rdbk
set_property PACKAGE_PIN T18 [get_ports acis_fault_rdbk]
set_property IOSTANDARD LVCMOS33 [get_ports acis_fault_rdbk]

#acis_reset
set_property PACKAGE_PIN P16 [get_ports acis_reset]
set_property IOSTANDARD LVCMOS33 [get_ports acis_reset]

#acis_force_trip
set_property PACKAGE_PIN R17 [get_ports acis_force_trip]
set_property IOSTANDARD LVCMOS33 [get_ports acis_force_trip]

#acis_keylock
set_property PACKAGE_PIN N15 [get_ports acis_keylock]
set_property IOSTANDARD LVCMOS33 [get_ports acis_keylock]







