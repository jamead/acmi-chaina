library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.besocm_package.ALL;


entity calc_pulse_stats is
  port ( 
   clk              : in std_logic;
   trig             : in std_logic;
   adc_data         : in signed(15 downto 0);
   adc_data_dly     : in signed(15 downto 0);
   gate_start       : in std_logic_vector(31 downto 0);
   gate_width       : in std_logic_vector(31 downto 0);
   threshold        : in signed(15 downto 0);
   adc_samplenum    : in std_logic_vector(31 downto 0);
   pulse_stats      : out pulse_stats_type;
   gate             : out std_logic
  );    
end calc_pulse_stats;


architecture behv of calc_pulse_stats is


  
  signal max_adc          : std_logic_vector(15 downto 0) := 16d"0";
  signal found_pulse      : std_logic;
  signal found_peak       : std_logic;
  signal peak             : signed(16 downto 0);  
  signal peak_sampnum     : std_logic_vector(31 downto 0);
  signal peak_val         : std_logic;         
  signal baseline         : signed(15 downto 0);
  signal baseline_val     : std_logic;
  signal integral         : signed(31 downto 0);
  signal integral_val     : std_logic;
  signal trig_sync        : std_logic;
  signal fwhm             : unsigned(15 downto 0);
  signal fwhm_val         : std_logic;
  --signal gate             : std_logic;



  
  
  attribute mark_debug                 : string;
  --attribute mark_debug of adc_data: signal is "true";
  --attribute mark_debug of adc_data_dly: signal is "true";  

  attribute mark_debug of found_pulse: signal is "true";
  attribute mark_debug of found_peak: signal is "true";
  attribute mark_debug of peak: signal is "true";   
  attribute mark_debug of baseline: signal is "true";
  attribute mark_debug of baseline_val: signal is "true";
  attribute mark_debug of integral: signal is "true";
  attribute mark_debug of integral_val: signal is "true";
  attribute mark_debug of adc_samplenum: signal is "true";
  attribute mark_debug of gate_start: signal is "true";
  attribute mark_debug of gate: signal is "true";
  attribute mark_debug of trig_sync: signal is "true";
  
  
  
  
begin  


pulse_stats.baseline <= std_logic_vector(baseline);
pulse_stats.integral <= std_logic_vector(integral);
pulse_stats.peak <= std_logic_vector(peak);
pulse_stats.peak_index <= peak_sampnum;
pulse_stats.threshold <= std_logic_vector(threshold);
pulse_stats.fwhm <= std_logic_vector(fwhm);
pulse_stats.peak_found <= found_peak;





gen_window: entity work.gen_gate
  port map (
   clk => clk, 
   trig => trig, 
   adc_samplenum => adc_samplenum,  
   gate_start => gate_start, 
   width => gate_width,                  
   gate => gate              
  );    


find_peak: entity work.find_peak
  port map (
   clk => clk,    
   trig => trig,             
   adc_data => adc_data,
   gate =>  gate,
   threshold => threshold,
   baseline => baseline,
   sampnum => adc_samplenum,
   found_pulse => found_pulse, 
   found_peak => found_peak, 
   peak => peak,
   peak_sampnum => peak_sampnum,
   peak_val => peak_val                
  );    



adc_baseline: entity work.calc_baseline
  port map (
   clk => clk, 
   trig => trig,
   start_calc => found_peak,                   
   adc_data => adc_data_dly,
   baseline => baseline, 
   baseline_val => baseline_val              
  );    



pulse_integral: entity work.calc_integral
  port map (
   clk => clk, 
   trig => trig,
   start_calc => baseline_val, 
   baseline => baseline,                  
   adc_data => adc_data_dly,
   integral => integral, 
   integral_val => integral_val              
  );    


pulse_fwhm: entity work.calc_fwhm
  port map (
   clk => clk, 
   trig => trig, 
   start_calc => baseline_val,   
   baseline => baseline, 
   peak => peak,                
   adc_data => adc_data_dly, 
   fwhm => fwhm,
   fwhm_val => fwhm_val              
  );    



end behv;
