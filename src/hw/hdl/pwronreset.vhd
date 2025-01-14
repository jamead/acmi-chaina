-------------------------------------------------------------------------------
-- Title         : Power on reset
-------------------------------------------------------------------------------

-- 08/19/2015: created.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
  
entity pwronreset is
generic(
    SIM_MODE			: integer := 0
    );
  port (
    clk          	    : in  std_logic;  
    fault_no_clock      : in std_logic;
    reset               : out std_logic
  );    
end pwronreset;

architecture rtl of pwronreset is

constant RESET_TIME_SIM     : std_logic_vector(31 downto 0) := 32d"2500";
constant RESET_TIME_SYNTH   : std_logic_vector(31 downto 0) := 32d"50000000";

signal reset_cntr           : std_logic_vector(31 downto 0) := 32d"0";
signal reset_time           : std_logic_vector(31 downto 0);


   --debug signals (connect to ila)
   attribute mark_debug                 : string;
   attribute mark_debug of fault_no_clock: signal is "true";   
   attribute mark_debug of reset: signal is "true";
   attribute mark_debug of reset_cntr: signal is "true";


begin  


sim_reset: if (SIM_MODE = 1) generate reset_sim_settings:
  reset_time <= RESET_TIME_SIM;
end generate;
synth_reset : if (SIM_MODE = 0) generate reset_synth_settings:
  reset_time <= RESET_TIME_SYNTH;
end generate;


process(clk,fault_no_clock)
  begin
--    if (fault_no_clock = '0') then
--       reset <= '1';
--       reset_cntr <= 24d"0";
    if (rising_edge(clk)) then
      --25 ms reset delay
      if (reset_cntr < RESET_TIME) then
        reset_cntr <= reset_cntr + 1;
        reset <= '1';
      elsif (reset_cntr >= RESET_TIME) then
        reset <= '0';
      else
        reset <= '0';
        reset_cntr <= 32d"1";
      end if;
    end if;
  end process;
  
end rtl;
