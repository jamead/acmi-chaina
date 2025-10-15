library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.besocm_package.ALL;


entity pulse_stats is

  port ( 
   clk              : in std_logic;
   adc_data         : in signed(15 downto 0);
   adc_data_dly     : in signed(15 downto 0);
   gate             : in std_logic;
   threshold        : in signed(15 downto 0);
   polarity         : in std_logic;
   tp_results       : out test_pulse_type    
  );    
end pulse_stats;


architecture behv of calc_charge is

component adc_shift_ram
  port (
    d : in std_logic_vector(15 downto 0); 
    clk : in std_logic; 
    q : out std_logic_vector(15 downto 0)
  );
end component; 

  constant ACCUMLEN       : INTEGER := 31;
  constant POS_PULSE      : std_logic := '0';
  constant NEG_PULSE      : std_logic := '1';
  constant THRESHOLD_TP1  : signed  := 16d"8000";     -- +2 nC
  constant THRESHOLD_TP2  : signed  := 16d"60000";    -- -2 nC
  constant THRESHOLD_TP3  : signed  := 16d"65000";    -- -0.3 nC
  constant THRESHOLD_TP4  : signed  := 16d"40000";    -- -18 nC
  
  signal max_adc          : std_logic_vector(15 downto 0) := 16d"0";
  signal adc_data_dly     : std_logic_vector(15 downto 0) := 16d"0";
  signal found_pulse      : std_logic;
  signal found_peak       : std_logic;
  signal peak_adcval      : std_logic_vector(15 downto 0);           
  signal baseline         : std_logic_vector(15 downto 0);
  signal baseline_val     : std_logic;
  signal integral         : std_logic_vector(31 downto 0);
  signal integral_val     : std_logic;
  signal trig_sync        : std_logic;

  signal found_pulse_tp1  : std_logic;
  signal found_peak_tp1   : std_logic;
  signal peak_adcval_tp1  : std_logic_vector(15 downto 0);
  signal found_pulse_tp2  : std_logic;
  signal found_peak_tp2   : std_logic;
  signal peak_adcval_tp2  : std_logic_vector(15 downto 0);
  signal found_pulse_tp3  : std_logic;
  signal found_peak_tp3   : std_logic;
  signal peak_adcval_tp3  : std_logic_vector(15 downto 0);
  signal found_pulse_tp4  : std_logic;
  signal found_peak_tp4   : std_logic;
  signal peak_adcval_tp4  : std_logic_vector(15 downto 0);  
  
  
  
  attribute mark_debug                 : string;
  attribute mark_debug of adc_data: signal is "true";
  attribute mark_debug of adc_data_dly: signal is "true";  
  attribute mark_debug of test_pulse_gates: signal is "true";
  attribute mark_debug of found_pulse: signal is "true";
  attribute mark_debug of found_peak: signal is "true";
  attribute mark_debug of peak_adcval: signal is "true";   
  attribute mark_debug of baseline: signal is "true";
  attribute mark_debug of baseline_val: signal is "true";
  attribute mark_debug of integral: signal is "true";
  attribute mark_debug of integral_val: signal is "true";
  attribute mark_debug of tp_results: signal is "true"; 
  attribute mark_debug of trig_sync: signal is "true";
  
  
  
  
begin  

--delay the adc data by 48 clocks, 
adc_dly : adc_shift_ram
  PORT MAP (
    D => adc_data,
    CLK => clk,
    Q => adc_data_dly
  );



find_peak_tp1: entity work.find_peak
  port map (
   clk => clk,                  
   adc_data => signed(adc_data),
   gate =>  test_pulse_gates(5),
   threshold => THRESHOLD_TP1,
   polarity => POS_PULSE,
   found_pulse => found_pulse_tp1, 
   found_peak => found_peak_tp1, 
   peak_adcval => peak_adcval_tp1                
  );    


find_peak_tp2: entity work.find_peak
  port map (
   clk => clk,                  
   adc_data => signed(adc_data),
   gate =>  test_pulse_gates(2),
   threshold => THRESHOLD_TP2,
   polarity => NEG_PULSE,
   found_pulse => found_pulse_tp2, 
   found_peak => found_peak_tp2, 
   peak_adcval => peak_adcval_tp2                
  );    


find_peak_tp3: entity work.find_peak
  port map (
   clk => clk,                  
   adc_data => signed(adc_data),
   gate =>  test_pulse_gates(0),
   threshold => THRESHOLD_TP3,
   polarity => NEG_PULSE,
   found_pulse => found_pulse_tp3, 
   found_peak => found_peak_tp3, 
   peak_adcval => peak_adcval_tp3                
  );    


find_peak_tp4: entity work.find_peak
  port map (
   clk => clk,                  
   adc_data => signed(adc_data),
   gate =>  test_pulse_gates(4),
   threshold => THRESHOLD_TP4,
   polarity => NEG_PULSE,
   found_pulse => found_pulse_tp4, 
   found_peak => found_peak_tp4, 
   peak_adcval => peak_adcval_tp4                
  );    





adc_baseline: entity work.calc_baseline
  port map (
   clk => clk, 
   start_calc => found_peak,                   
   adc_data => adc_data_dly,
   baseline => baseline, 
   baseline_val => baseline_val              
  );    


pulse_integral: entity work.calc_integral
  port map (
   clk => clk, 
   start_calc => baseline_val, 
   baseline => baseline,                  
   adc_data => adc_data_dly,
   integral => integral, 
   integral_val => integral_val              
  );    

check_tp0 : entity work.check_testpulse
  port map (
    clk => clk,
    gate => test_pulse_gates(4),
    baseline => baseline,
    integral => integral,
    integral_val => integral_val,
    test_pulse_val => open, 
    test_pulse_baseline => tp_results.tp0_baseline,
    test_pulse_integral => tp_results.tp0_integral
 );
 
 check_tp1 : entity work.check_testpulse
  port map (
    clk => clk,
    gate => test_pulse_gates(5),
    baseline => baseline,
    integral => integral,
    integral_val => integral_val,
    test_pulse_val => open, 
    test_pulse_baseline => tp_results.tp1_baseline,
    test_pulse_integral => tp_results.tp1_integral
 );
 
 check_tp2 : entity work.check_testpulse
  port map (
    clk => clk,
    gate => test_pulse_gates(6),
    baseline => baseline,
    integral => integral,
    integral_val => integral_val,
    test_pulse_val => open, 
    test_pulse_baseline => tp_results.tp2_baseline, 
    test_pulse_integral => tp_results.tp2_integral
 );
 
 check_tp3 : entity work.check_testpulse
  port map (
    clk => clk,
    gate => test_pulse_gates(7),
    baseline => baseline,
    integral => integral,
    integral_val => integral_val,
    test_pulse_val => open, 
    test_pulse_baseline => tp_results.tp3_baseline, 
    test_pulse_integral => tp_results.tp3_integral
 );
 

end behv;
