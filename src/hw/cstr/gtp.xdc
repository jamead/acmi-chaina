


create_clock -period 6.400 [get_ports gtp_refclk1_p]

set_property PACKAGE_PIN F10 [get_ports gtp_refclk1_p]
set_property PACKAGE_PIN E10 [get_ports gtp_refclk1_n]

##---------- Set placement for gt0_gtp_wrapper_i/GTPE2_CHANNEL ------
set_property LOC GTPE2_CHANNEL_X0Y4 [get_cells backend_gtp/kria_comm_support_i/kria_comm_init_i/U0/kria_comm_i/gt0_kria_comm_i/gtpe2_i]




