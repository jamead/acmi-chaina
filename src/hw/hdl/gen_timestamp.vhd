-------------------------------------------------------------------------------
-- Title         : Power on reset
-------------------------------------------------------------------------------

-- 08/19/2015: created.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
  
entity gen_timestamp is
  port (
    clk          	    : in  std_logic;  
    reset               : in std_logic;
    accum_update        : out std_logic;
    timestamp           : out std_logic_vector(31 downto 0);
    watchdog_clock      : out std_logic   
  );    
end gen_timestamp;

architecture behv of gen_timestamp is

signal clk_cnt_a        : std_logic_vector(31 downto 0);
signal clk_cnt_b        : std_logic_vector(31 downto 0);


begin  


--2Hz accumulator update trigger
process(clk)
  begin
    if (rising_edge(clk)) then
      if (reset = '1') then
        clk_cnt_a <= 32d"0"; 
        accum_update <= '0'; 
      --elsif (clk_cnt_a >= 32d"1000") then            
      elsif (clk_cnt_a >= 32d"100000000") then
        accum_update <= '1';
        clk_cnt_a <= 32d"0";
      else
        accum_update <= '0';
        clk_cnt_a <= clk_cnt_a + 1;
      end if;
    end if;
  end process;
  
  

  
  
--1Hz timestamp and watchdog clock
process(clk)
  begin
    if (rising_edge(clk)) then
      if (reset = '1') then
        timestamp <= 32d"0";
        clk_cnt_b <= 32d"0"; 
        watchdog_clock <= '0';
      elsif (clk_cnt_b >= 32d"200000000") then
        timestamp <= timestamp + 1;
        clk_cnt_b <= 32d"0";
        watchdog_clock <= not watchdog_clock;
      else
        clk_cnt_b <= clk_cnt_b + 1;
      end if;
    end if;
  end process;  
  
  
end behv;
