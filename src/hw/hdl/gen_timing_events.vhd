-------------------------------------------------------------------------------
-- Title         : generate timing events
-------------------------------------------------------------------------------

-- 08/19/2015: created.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.acmi_package.ALL;


entity gen_timing_events is 
  port (
    clk          	    : in std_logic;  
    reset               : in std_logic;
    eeprom_rdy          : in std_logic;
    trig                : in std_logic;
    eeprom_params       : in eeprom_parameters_type;
    cntrl_params        : in cntrl_parameters_type;
    acis_keylock        : in std_logic;
    beam_detect_window  : out std_logic;
    beam_cycle_window   : out std_logic;
    adc_samplenum       : out std_logic_vector(31 downto 0);
    tp_pos_pulse        : out std_logic_vector(4 downto 0);
    tp_neg_pulse        : out std_logic_vector(4 downto 0);
    timestamp           : out std_logic_vector(31 downto 0);
    watchdog_clock      : out std_logic;
    watchdog_pulse      : out std_logic;
    startup_cnt         : out std_logic_vector(31 downto 0);
    fault_startup       : out std_logic   
  );    
end gen_timing_events;

architecture behv of gen_timing_events is

  signal clk_cnt          : std_logic_vector(31 downto 0);
  signal ext_trig         : std_logic;
  signal fp_trig_out      : std_logic;

   --debug signals (connect to ila)
--   attribute mark_debug                 : string;
--   attribute mark_debug of beam_detect_window: signal is "true";       
--   attribute mark_debug of beam_cycle_window: signal is "true";
--   attribute mark_debug of fp_trig_out: signal is "true";
--   attribute mark_debug of pzed_params: signal is "true";
--   attribute mark_debug of trig_out: signal is "true";
--   attribute mark_debug of ext_trig: signal is "true";
--   attribute mark_debug of fiber_trig_fp: signal is "true";

begin  


--watchdog pulse no longer used.  U54 is removed and pin 6 is shorted to pin 8.
watchdog_pulse <= '1';


  
gen_startup_fault: entity work.gen_startup_dly
  port map (
    clk => clk,   
    reset => reset, 
    trig => trig,
    acis_keylock => acis_keylock,
    startup_delay => eeprom_params.accum_length, 
    startup_dly_cnt => startup_cnt, 
    startup_fault => fault_startup  
  );    


  
-- generate 1Hz timestamp for watchdog clock
gen_rtc: entity work.gen_timestamp
  port map(
    clk => clk,
    reset => reset,
    timestamp => timestamp,
    watchdog_clock => watchdog_clock
);  



--generates test pulses
gen_tp: entity work.gen_test_pulses
  port map ( 
   clk => clk, 
   reset => reset, 
   trig => trig,  
   params => eeprom_params, 
   tp_pos_pulse => tp_pos_pulse,
   tp_neg_pulse => tp_neg_pulse 
  );    
  
  
-- used for accumulator.   Accumulator is updated
-- at the falling edge of beam_detect_window 
calc_active: entity work.beam_detect_window
  port map (
   clk => clk, 
   trig => trig,                  
   gate => beam_detect_window              
  );    
  
 
-- is this needed?  
cycle_window: entity work.gen_window 
  port map(
   clk => clk, 
   trig => trig, 
   delay => 32d"1", 
   width => 16d"16100",                 
   gate => beam_cycle_window              
  );     
   
  
sampnum:  entity work.gen_samplenum
  port map (
   clk => clk, 
   trig => trig,   
   samplenum => adc_samplenum           
  );    
  
  
end behv;  