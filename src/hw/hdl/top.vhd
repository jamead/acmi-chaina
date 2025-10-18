----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2021 04:37:10 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
 
library work;
use work.acmi_package.ALL;

entity top is
generic(
    FPGA_VERSION			: integer := 1;
    SIM_MODE				: integer := 0
    );
  port(
     -- adc ltc2107
    adc_spi_cs              : out std_logic;
    adc_spi_sck             : out std_logic;
    adc_spi_sdi             : out std_logic;
    adc_spi_sdo             : in std_logic;
    adc_clk_p               : in std_logic;
    adc_clk_n               : in std_logic;
    adc_data_p              : in std_logic_vector(7 downto 0);
    adc_data_n              : in std_logic_vector(7 downto 0);  
    adc_of_p                : in std_logic;
    adc_of_n                : in std_logic;
    
    -- trigger input from fiber
    fiber_trig_in           : in std_logic;
    fiber_trig_led          : out std_logic;
    fiber_trig_fp           : out std_logic;
    
    -- waveform data to picoZed
    waveform_data_p         : out std_logic_vector(15 downto 0);
    waveform_data_n         : out std_logic_vector(15 downto 0);
    waveform_clk_p          : out std_logic;
    waveform_clk_n          : out std_logic;
    waveform_sel_p          : out std_logic;
    waveform_sel_n          : out std_logic;
    waveform_enb_p          : out std_logic;
    waveform_enb_n          : out std_logic;
    
    -- picozed spi
    pzed_spi_sclk           : in std_logic;                    
    pzed_spi_din            : out std_logic; 
    pzed_spi_dout           : in std_logic; 
    pzed_spi_cs             : in std_logic;   
    
    --test pulse signals       
    tp_pos_pulse            : out std_logic_vector(4 downto 0);
    tp_neg_pulse            : out std_logic_vector(4 downto 0);

    --test pulse DAC
    dac_tp_data             : out std_logic_vector(13 downto 0);
    dac_tp_clk              : out std_logic;
    
    --front panel debug DAC
    dac_fp_data             : out std_logic_vector(13 downto 0);
    dac_fp_clk              : out std_logic;
    
    --fault input readbacks
    fault_bad_power         : in std_logic;
    fault_no_clock          : in std_logic;
    fault_no_pulse          : in std_logic;
    fault_no_trigger        : in std_logic;
    
    -- fault outputs (active low)
    faultsn                 : out std_logic_vector(11 downto 0);

    --latched fault input readbacks
    faults_lat              : in std_logic_vector(15 downto 0);

    --acis signals readbacks
    acis_faultn             : in std_logic;
    acis_fault_rdbk         : in std_logic;
    acis_reset              : in std_logic;
    acis_force_trip         : in std_logic;
    acis_keylock            : in std_logic;         
    
    --watchdog signals
    watchdog_pulse          : out std_logic;
    watchdog_clock          : out std_logic;
    
    --eeprom
    eeprom_csn              : out std_logic;
    eeprom_sck              : out std_logic;
    eeprom_sdi              : out std_logic;
    eeprom_holdn            : out std_logic;
    eeprom_sdo              : in std_logic;
    
    keylock_detect_led      : out std_logic;
        
    dbg                     : out std_logic_vector(9 downto 0);
    dbg_leds                : out std_logic_vector(3 downto 0)
    
    );
end top;
 
architecture behv of top is

  signal reset              : std_logic;
  signal adc_data           : std_logic_vector(15 downto 0);
  signal adc_data_dly       : std_logic_vector(15 downto 0);
  signal adc_clk            : std_logic;
  signal adc_sat            : std_logic;
  signal adc_samplenum      : std_logic_vector(31 downto 0);
  
  signal waveform_data      : std_logic_vector(15 downto 0);
  signal waveform_clk       : std_logic;
  signal waveform_enb       : std_logic;
  signal waveform_sel       : std_logic;
  
  signal spi_xfer           : std_logic;
  signal spi_xfer_stretch   : std_logic;
  
  signal soft_trig          : std_logic;
  
  signal beam_detect_window : std_logic;
  signal beam_cycle_window  : std_logic;
  
  signal faults_rdbk        : std_logic_vector(15 downto 0);
  signal fault_startup      : std_logic;
  signal startup_cnt        : std_logic_vector(31 downto 0);
  
  signal pulse_stats        : pulse_stats_array;
  signal cntrl_params       : cntrl_parameters_type;
  signal eeprom_params      : eeprom_parameters_type;
  signal eeprom_data        : eeprom_data_type;
  signal eeprom_rdy         : std_logic;
  signal trig               : std_logic;
  signal ext_trig           : std_logic;
  signal trig_stretch       : std_logic;
  signal fp_trig_dly_out    : std_logic;
  
  signal beam_pulse_detect  : std_logic;
  signal trig_out_delay     : std_logic_vector(31 downto 0);
  signal trig_out_enable    : std_logic;
  
  signal timestamp          : std_logic_vector(31 downto 0);
  signal accum              : std_logic_vector(31 downto 0);
  signal charge_oow         : std_logic_vector(31 downto 0);
  signal accum_update       : std_logic;

  signal dac_data           : std_logic_vector(15 downto 0);
  signal acis_readbacks     : std_logic_vector(7 downto 0);
  
  signal tp_gates           : std_logic_vector(3 downto 0);
  
  signal acis_reset_debounced  : std_logic;
  signal acis_force_trip_debounced : std_logic;
  signal acis_keylock_debounced : std_logic;

 
   --debug signals (connect to ila)
   attribute mark_debug                 : string;
   attribute mark_debug of adc_data: signal is "true";        
   attribute mark_debug of soft_trig: signal is "true"; 
   attribute mark_debug of fiber_trig_in: signal is "true";
   attribute mark_debug of ext_trig: signal is "true";
   attribute mark_debug of trig: signal is "true"; 
   attribute mark_debug of waveform_data: signal is "true";
   attribute mark_debug of waveform_enb: signal is "true";
   
--   attribute mark_debug of fault_bad_power: signal is "true";
--   attribute mark_debug of fault_no_clock: signal is "true";  
--   attribute mark_debug of fault_no_pulse: signal is "true";  
--   attribute mark_debug of fault_no_trigger: signal is "true";   
   
--   attribute mark_debug of acis_faultn: signal is "true";   
--   attribute mark_debug of acis_fault_rdbk: signal is "true";   
--   attribute mark_debug of acis_reset: signal is "true";   
--   attribute mark_debug of acis_force_trip: signal is "true";   
--   attribute mark_debug of acis_keylock: signal is "true";          




begin


dbg(0) <= adc_clk;
dbg(1) <= '0'; --tp_pos_pulse(0); --watchdog_clock; --'0';
dbg(2) <= '0'; --tp_p_pos(1); --fault_no_clock; --'0';
dbg(3) <= '0'; --tp_pulse_pos(2); --fault_no_pulse; --'0';
dbg(4) <= '0'; --tp_pulse_pos(3); --fault_bad_power; --'0';
dbg(5) <= '0'; --tp_pulse_neg(0); --beam_pulse_detect; --'0';
dbg(6) <= '0'; --tp_pulse_neg(1); --soft_trig; --'0'; --pzed_spi_sclk;
dbg(7) <= '0'; --tp_pulse_neg(2); --'0'; --pzed_spi_din;
dbg(8) <= fiber_trig_in; --ext_trig; --'0'; --pzed_spi_dout;
dbg(9) <= trig; --'0'; --pzed_spi_cs;


--pzed_spi_din <= led_i;

dbg_leds(0) <= trig_stretch; --'0';
dbg_leds(1) <= reset; --'0'; --not led_i;
dbg_leds(2) <= '0';
dbg_leds(3) <= spi_xfer_stretch; --'0'; --'1';





-- temp trigger from J8 SMA input
gen_trig: entity work.gen_trig_pulse
  port map(
   clk => adc_clk,        
   trig => fiber_trig_in,                  
   pulse => ext_trig              
  );    

trig <= ext_trig or soft_trig; 




fiber_trig_fp <= fp_trig_dly_out; 

--inverter on LED drivers
fiber_trig_led <= not trig_stretch; 
keylock_detect_led <= not acis_keylock_debounced;



dac_tp_clk <= adc_clk;
dac_fp_clk <= adc_clk;
process (adc_clk)
begin
  if (falling_edge(adc_clk)) then
     dac_tp_data <= dac_data(15 downto 2); 
     --dac_tp_clk <= not adc_clk;
     dac_fp_data <= dac_data(15 downto 2); 
     --dac_fp_clk <= not adc_clk;
  end if;
end process;


--generate power-on reset pulse
gen_rst: entity work.pwronreset
generic map (
    SIM_MODE => SIM_MODE
  )
  port map(
    clk => adc_clk, 
    fault_no_clock => fault_no_clock,
    reset => reset
  );    
  
  
debounce_acis_reset: entity work.debounce
  port map (
    clk => adc_clk,
    reset => reset,
    switch => acis_reset,
    clean => acis_reset_debounced
);
  
debounce_acis_force_trip: entity work.debounce
  port map (
    clk => adc_clk,
    reset => reset,
    switch => acis_force_trip,
    clean => acis_force_trip_debounced
);  
  
debounce_acis_keylock: entity work.debounce
  port map (
    clk => adc_clk,
    reset => reset,
    switch => acis_keylock,
    clean => acis_keylock_debounced
);    
  


timing: entity work.gen_timing_events
  port map(
    clk => adc_clk,
    reset => reset,
    eeprom_rdy => eeprom_rdy,
    trig=> trig, 
    eeprom_params => eeprom_params, 
    cntrl_params => cntrl_params,
    acis_keylock => acis_keylock_debounced,    
    beam_detect_window => beam_detect_window,
    beam_cycle_window => beam_cycle_window,
    adc_samplenum => adc_samplenum,
    tp_pos_pulse => tp_pos_pulse,
    tp_neg_pulse => tp_neg_pulse,
    timestamp => timestamp,
    watchdog_clock => watchdog_clock,
    watchdog_pulse => watchdog_pulse,
    startup_cnt => startup_cnt, 
    fault_startup => fault_startup,
    fp_trig_dly_out => fp_trig_dly_out   
    
 );





-- generate fault conditions
gen_faults: entity work.faults
  port map (
    clk => adc_clk,
    reset => reset,
    beam_cycle_window => beam_cycle_window,
    trig => trig,
    params => eeprom_params, --pzed_params,
    pulse_stats => pulse_stats,
    accum => accum, 
    fault_startup => fault_startup,   
    fault_bad_power => fault_bad_power,
    fault_no_clock => fault_no_clock, 
    fault_no_pulse => fault_no_pulse, 
    fault_no_trigger => fault_no_trigger,
    acis_faultn => acis_faultn,
    acis_fault_rdbk => acis_fault_rdbk,
    acis_reset => acis_reset_debounced, 
    acis_force_trip => acis_force_trip_debounced,
    acis_keylock => acis_keylock_debounced,       
    acis_readbacks => acis_readbacks,
    adc_sat => adc_sat,
    faultsn => faultsn,
    faults_rdbk => faults_rdbk,
    watchdog_pulse => open, --watchdog_pulse,
    beam_pulse_detect => beam_pulse_detect
);


--configures and reads ADC
adc : entity work.adc_interface
  generic map (
    SIM_MODE => SIM_MODE
  )
  port map (
    reset => reset,
    trig => trig,
    sclk => adc_spi_sck,                    
    din => adc_spi_sdi, 
    dout => adc_spi_sdo, 
    sync => adc_spi_cs,     
    adc_clk_p => adc_clk_p,
    adc_clk_n => adc_clk_n,
    adc_data_p => adc_data_p,
    adc_data_n => adc_data_n,
    adc_of_p => adc_of_p,
    adc_of_n => adc_of_n,
    adc_data_2s => adc_data,
    adc_data_ob => dac_data,
    adc_clk => adc_clk,
    adc_sat => adc_sat
  );




-- calculates all metrics on beam and test pulses
calc_q: entity work.calc_charge
  port map (
   clk => adc_clk,
   trig => trig,
   adc_samplenum => adc_samplenum,
   test_pulse_gates => tp_gates, 
   params => eeprom_params,              
   adc_data_raw => adc_data, 
   adc_data_inv_dly => adc_data_dly, 
   pulse_stats => pulse_stats  
  );    


-- 15 min charge accumulator
boxcar: entity work.accumulator
  port map(
    clk => adc_clk, 
    rst => cntrl_params.accum_reset, 
    faultn => acis_faultn,
    accum_len => eeprom_params.accum_length(12 downto 0),
    beam_detect_window => beam_detect_window, 
    q_min => eeprom_params.accum_q_min,
    sample => pulse_stats(0).integral,
    charge_oow => charge_oow,
    accum => accum
);



-- picoZed to artix slow control SPI interface
spi_comm: entity work.pzed_spi
  port map(
    clk => adc_clk,  
    rst => reset,    
    acis_keylock => acis_keylock_debounced,             
    sclk => pzed_spi_sclk,                    
    din => pzed_spi_dout, 
    dout => pzed_spi_din, 
    csn => pzed_spi_cs,
    spi_xfer => spi_xfer,
    soft_trig => soft_trig,
    params => cntrl_params              
 );    



--artix to picoZed data 
send_results: entity work.tx_pzed_data
  generic map (
    FPGA_VERSION => FPGA_VERSION
  )
  port map (
    clk => adc_clk, 
    reset => reset, 
    trig => trig, 
    startup_cnt => startup_cnt,
    acis_readbacks => acis_readbacks,
    beam_cycle_window => beam_cycle_window,
    adc_data => adc_data, 
    adc_data_dly => adc_data_dly,
    pulse_stats => pulse_stats,
    eeprom_params => eeprom_params, 
    faults_rdbk => faults_rdbk,
    faults_lat => faults_lat, 
    timestamp => timestamp,
    accum => accum,
    charge_oow => charge_oow,
    pzed_clk => waveform_clk,
    pzed_data => waveform_data, 
    pzed_enb => waveform_enb, 
    pzed_sel => waveform_sel            
 );    




-- non-volatile memory for settings
eeprom: entity work.eeprom_interface
  generic map (
    SIM_MODE => SIM_MODE
  )
  port map(
    clk => adc_clk,                   
    reset => reset,  
    cntrl_params => cntrl_params,                            
    eeprom_params => eeprom_params,
    acis_keylock => acis_keylock_debounced,
    sclk => eeprom_sck,                    
    din => eeprom_sdi, 
    dout => eeprom_sdo,
    csn => eeprom_csn, 
    holdn => eeprom_holdn,
    eeprom_rdy => eeprom_rdy                 
);    



stretch_0 : entity work.stretch
  port map (
	clk => adc_clk,
	reset => '0', 
	sig_in => spi_xfer,  
	len => 4000000, -- ~25ms;
	sig_out => spi_xfer_stretch  
);	  	

stretch_1 : entity work.stretch
  port map (
	clk => adc_clk,
	reset => '0', 
	sig_in => trig,  
	len => 4000000, -- ~25ms;
	sig_out => trig_stretch  
);	  	





-- lvds output buffers 
waveform_enb_lvds      : OBUFDS  port map (O => waveform_enb_p, OB => waveform_enb_n, I => waveform_enb);
waveform_clk_lvds      : OBUFDS  port map (O => waveform_clk_p, OB => waveform_clk_n, I => waveform_clk);
waveform_sel_lvds      : OBUFDS  port map (O => waveform_sel_p, OB => waveform_sel_n, I => waveform_sel);

waveform_lvds : for i in 0 to 15 generate
 begin
    data_inst : OBUFDS port map (O => waveform_data_p(i), OB => waveform_data_n(i), I => waveform_data(i));
end generate;
    




end behv;
