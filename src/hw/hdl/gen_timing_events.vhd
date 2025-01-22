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
    soft_trig           : in std_logic;
    fiber_trig_in       : in std_logic;
    eeprom_params       : in eeprom_parameters_type;
    pzed_params         : in pzed_parameters_type;
    acis_keylock        : in std_logic;
    trig_out            : out std_logic;
    beam_detect_window  : out std_logic;
    beam_cycle_window   : out std_logic;
    adc_samplenum       : out std_logic_vector(31 downto 0);
    accum_update        : out std_logic;
    tp_pos_pulse        : out std_logic_vector(4 downto 0);
    tp_neg_pulse        : out std_logic_vector(4 downto 0);
    fiber_trig_fp       : out std_logic;
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


trig_out <= ext_trig or soft_trig;

--watchdog pulse no longer used.  U54 is removed and pin 6 is shorted to pin 8.
watchdog_pulse <= '1';


-- generate main trigger from input fiber
gen_trig: entity work.gen_trig_pulse
  port map(
   clk => clk,        
   trig => fiber_trig_in,                  
   pulse => ext_trig              
  );    
  
  
gen_startup_fault: entity work.gen_startup_dly
  port map (
    clk => clk,   
    reset => reset, 
    acis_keylock => acis_keylock,
    eeprom_rdy => eeprom_rdy,
    accum_update => accum_update, 
    startup_delay => eeprom_params.accum_length, 
    startup_dly_cnt => startup_cnt, 
    startup_fault => fault_startup  
  );    


  
-- generate 1Hz timestamp for boxcar accumulator and watchdog clock
gen_rtc: entity work.gen_timestamp
  port map(
    clk => clk,
    reset => reset,
    accum_update => accum_update,
    timestamp => timestamp,
    watchdog_clock => watchdog_clock
);  



--generates test pulses
gen_tp: entity work.gen_test_pulses
  port map ( 
   clk => clk, 
   reset => reset, 
   trig => trig_out, --soft_trig,  
   params => eeprom_params, 
   tp_pos_pulse => tp_pos_pulse,
   tp_neg_pulse => tp_neg_pulse 
  );    
  
  
calc_active: entity work.beam_detect_window
  port map (
   clk => clk, 
   trig => trig_out,                  
   gate => beam_detect_window              
  );    
  
  
cycle_window: entity work.gen_window 
  port map(
   clk => clk, 
   trig => trig_out, 
   delay => 32d"1", 
   width => 16d"16100",                 
   gate => beam_cycle_window              
  );     
  
  
fiber_trig_fp <= fp_trig_out when pzed_params.trig_out_enable = '1' else '0';

fp_trig: entity work.gen_window 
  port map(
   clk => clk, 
   trig => trig_out, 
   delay => pzed_params.trig_out_delay, 
   width => 16d"200",     -- 1us width            
   gate => fp_trig_out              
  );       
  
  
sampnum:  entity work.gen_samplenum
  port map (
   clk => clk, 
   trig => soft_trig, --ext_trig,  
   samplenum => adc_samplenum           
  );    
  
  
end behv;  