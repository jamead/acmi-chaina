-------------------------------------------------------------------------------
-- Title         : Faults TP 
--                 Isolates which fault happened for each test pulse
-------------------------------------------------------------------------------

-- 10/15/2021: created.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
  
library work;
use work.acmi_package.ALL;

  
entity faults_tp is
  port (
    clk          	    : in  std_logic;  
    reset               : in std_logic;
    beam_cycle_window   : in std_logic;
    pulse_stats         : in pulse_stats_array; 
    params              : in eeprom_parameters_type;
    faults_rdbk_tp      : out std_logic_vector(31 downto 0)
  );    
end faults_tp;

architecture behv of faults_tp is


    signal prev_beam_cycle_window       : std_logic;


    attribute mark_debug                  : string;
    attribute mark_debug of beam_cycle_window : signal is "true";



begin  




--check tp fault conditions at end of beam_cycle
check_faults: process (clk)
begin
  if (rising_edge(clk)) then
    if (reset = '1') then
      faults_rdbk_tp <= 32d"0";

      
    else
      prev_beam_cycle_window <= beam_cycle_window;
      
      --check rest of faults at end of beam cycle window (falling edge of beam_cycle_window)
      if (prev_beam_cycle_window = '1' and beam_cycle_window = '0') then
        
        --extended tests to isolate which fault happened with test pulse

        --tp2 problem -2nC
        if (pulse_stats(2).integral > params.tp2_int_high_limit)                  then  faults_rdbk_tp(8) <= '1'; else faults_rdbk_tp(8) <= '0'; end if;
        if (pulse_stats(2).integral < params.tp2_int_low_limit)                   then  faults_rdbk_tp(9) <= '1'; else faults_rdbk_tp(9) <= '0'; end if;
        if (signed(pulse_stats(2).baseline) > signed(params.tp2_base_high_limit)) then  faults_rdbk_tp(10) <= '1'; else faults_rdbk_tp(10) <= '0'; end if;
        if (signed(pulse_stats(2).baseline) < signed(params.tp2_base_low_limit))  then  faults_rdbk_tp(11) <= '1'; else faults_rdbk_tp(11) <= '0'; end if;
        if (pulse_stats(2).peak > params.tp2_peak_high_limit)                     then  faults_rdbk_tp(12) <= '1'; else faults_rdbk_tp(12) <= '0'; end if;       
        if (pulse_stats(2).peak < params.tp2_peak_low_limit)                      then  faults_rdbk_tp(13) <= '1'; else faults_rdbk_tp(13) <= '0'; end if;
        if (pulse_stats(2).fwhm > params.tp2_fwhm_high_limit)                     then  faults_rdbk_tp(14) <= '1'; else faults_rdbk_tp(14) <= '0'; end if; 
        if (pulse_stats(2).fwhm < params.tp2_fwhm_low_limit)                      then  faults_rdbk_tp(15) <= '1'; else faults_rdbk_tp(15) <= '0'; end if;

        --tp3 problem -18nC
        if (pulse_stats(3).integral > params.tp3_int_high_limit)                  then  faults_rdbk_tp(16) <= '1'; else faults_rdbk_tp(16) <= '0'; end if;
        if (pulse_stats(3).integral < params.tp3_int_low_limit)                   then  faults_rdbk_tp(17) <= '1'; else faults_rdbk_tp(17) <= '0'; end if;
        if (signed(pulse_stats(3).baseline) > signed(params.tp3_base_high_limit)) then  faults_rdbk_tp(18) <= '1'; else faults_rdbk_tp(18) <= '0'; end if;
        if (signed(pulse_stats(3).baseline) < signed(params.tp3_base_low_limit))  then  faults_rdbk_tp(19) <= '1'; else faults_rdbk_tp(19) <= '0'; end if;
        if (pulse_stats(3).peak > params.tp3_peak_high_limit)                     then  faults_rdbk_tp(20) <= '1'; else faults_rdbk_tp(20) <= '0'; end if;       
        if (pulse_stats(3).peak < params.tp3_peak_low_limit)                      then  faults_rdbk_tp(21) <= '1'; else faults_rdbk_tp(21) <= '0'; end if;
        if (pulse_stats(3).fwhm > params.tp3_fwhm_high_limit)                     then  faults_rdbk_tp(22) <= '1'; else faults_rdbk_tp(22) <= '0'; end if; 
        if (pulse_stats(3).fwhm < params.tp3_fwhm_low_limit)                      then  faults_rdbk_tp(23) <= '1'; else faults_rdbk_tp(23) <= '0'; end if;

        --tp1 problem +2nC
        if (pulse_stats(1).integral > params.tp1_int_high_limit)                  then  faults_rdbk_tp(0) <= '1'; else faults_rdbk_tp(0) <= '0'; end if;
        if (pulse_stats(1).integral < params.tp1_int_low_limit)                   then  faults_rdbk_tp(1) <= '1'; else faults_rdbk_tp(1) <= '0'; end if;
        if (signed(pulse_stats(1).baseline) > signed(params.tp1_base_high_limit)) then  faults_rdbk_tp(2) <= '1'; else faults_rdbk_tp(2) <= '0'; end if;
        if (signed(pulse_stats(1).baseline) < signed(params.tp1_base_low_limit))  then  faults_rdbk_tp(3) <= '1'; else faults_rdbk_tp(3) <= '0'; end if;
        if (pulse_stats(1).peak > params.tp1_peak_high_limit)                     then  faults_rdbk_tp(4) <= '1'; else faults_rdbk_tp(4) <= '0'; end if;       
        if (pulse_stats(1).peak < params.tp1_peak_low_limit)                      then  faults_rdbk_tp(5) <= '1'; else faults_rdbk_tp(5) <= '0'; end if;
        if (pulse_stats(1).fwhm > params.tp1_fwhm_high_limit)                     then  faults_rdbk_tp(6) <= '1'; else faults_rdbk_tp(6) <= '0'; end if; 
        if (pulse_stats(1).fwhm < params.tp1_fwhm_low_limit)                      then  faults_rdbk_tp(7) <= '1'; else faults_rdbk_tp(7) <= '0'; end if;

      end if;
    end if;
  end if;
end process;
   
   
   
   
   
   
end behv;
