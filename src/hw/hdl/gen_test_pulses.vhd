library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.acmi_package.ALL;


entity gen_test_pulses is
  port ( 
   clk              : in std_logic;
   reset            : in std_logic;
   trig             : in std_logic; 
   params           : in eeprom_parameters_type;
   tp_pulses        : out std_logic_vector(7 downto 0);
   tp_gates         : out std_logic_vector(3 downto 0) 
  );    
end gen_test_pulses;


architecture behv of gen_test_pulses is

  signal gate       : std_logic_vector(3 downto 0);
  signal pulse      : std_logic_vector(3 downto 0);
  signal en         : std_logic;
  signal addr       : std_logic_vector(1 downto 0);
 
 
  attribute mark_debug                 : string;
  attribute mark_debug of gate: signal is "true";       
  attribute mark_debug of pulse: signal is "true"; 
  attribute mark_debug of en: signal is "true";       
  attribute mark_debug of addr: signal is "true";  
  
  
begin  

--mapping to front end switch module
-- tp(0) : SW1  --18nC
-- tp(1) : SW2  -2nc
-- tp(2) : SW3   -0.3nC
-- tp(3) : SW4  +2nc
-- tp(4) : A0
-- tp(5) : A1
-- tp(6) : EN
-- tp(7) : N.C.


--mapping to Front End Switch module
-- 0  :  GATE 3   
-- 1  :  PULSE 3   -0.3nC
-- 2  :  GATE 2    
-- 3  :  PULSE 2   -2nC
-- 4  :  GATE 1    
-- 5  :  GATE 4  
-- 6  :  PULSE 1    +2nC
-- 7  :  PULSE 4   -18nC


tp_pulses(0) <= pulse(2); --pulse(3);
tp_pulses(1) <= pulse(1);
tp_pulses(2) <= pulse(3);
tp_pulses(3) <= pulse(0);
tp_pulses(4) <= gate(2); --addr(0);
tp_pulses(5) <= NOT gate(1); --addr(1);
tp_pulses(6) <= NOT gate(3); --en;
tp_pulses(7) <= gate(0); --'0';

tp_gates <= gate;

en <= gate(0) or gate(1) or gate(2) or gate(3);

addr <= "11" when gate(0) = '1' else 
        "01" when gate(1) = '1' else
        "10" when gate(2) = '1' else
        "00" when gate(3) = '1' else
        "00";


gate(3) <= '0';
pulse(3) <= '0';


tp1_gate: entity work.pulse_gen
  port map (
   clk => clk,                    
   reset => reset,   
   trig => trig, 
   pulsedly => params.tp1_gate_delay,  
   pulsehi => params.tp1_gate_width,
   pulse => gate(0)                   
  );    

tp1_pulse: entity work.pulse_gen
  port map (
   clk => clk,                    
   reset => reset,   
   trig => trig, 
   pulsedly => params.tp1_pulse_delay, 
   pulsehi => params.tp1_pulse_width, 
   pulse => pulse(0)                
  );    


tp2_gate: entity work.pulse_gen
  port map (
   clk => clk,                    
   reset => reset,   
   trig => trig, 
   pulsedly => params.tp2_gate_delay,  
   pulsehi => params.tp2_gate_width,
   pulse => gate(1)                  
  );    

tp2_pulse: entity work.pulse_gen
  port map (
   clk => clk,                    
   reset => reset,   
   trig => trig, 
   pulsedly => params.tp2_pulse_delay, 
   pulsehi => params.tp2_pulse_width, 
   pulse => pulse(1)                  
  );    


tp3_gate: entity work.pulse_gen
  port map (
   clk => clk,                    
   reset => reset,   
   trig => trig, 
   pulsedly => params.tp3_gate_delay,  
   pulsehi => params.tp3_gate_width,
   pulse => gate(2)                  
  );    

tp3_pulse: entity work.pulse_gen
  port map (
   clk => clk,                    
   reset => reset,   
   trig => trig, 
   pulsedly => params.tp3_pulse_delay, 
   pulsehi => params.tp3_pulse_width, 
   pulse => pulse(2)                  
  );    




end behv;
