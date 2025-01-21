-------------------------------------------------------------------------------
-- Title         : Power on reset
-------------------------------------------------------------------------------

-- 08/19/2015: created.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
  
entity gen_startup_dly is
  port (
    clk          	    : in std_logic;  
    reset               : in std_logic;
    acis_keylock        : in std_logic;
    eeprom_rdy          : in std_logic;
    accum_update        : in std_logic;
    startup_delay       : in std_logic_vector(31 downto 0);
    startup_dly_cnt     : out std_logic_vector(31 downto 0);
    startup_fault       : out std_logic  
  );    
end gen_startup_dly;

architecture behv of gen_startup_dly is


  signal eeprom_rdy_last       : std_logic;
  signal startup_enb           : std_logic;
  signal acis_keylock_last     : std_logic;
 
 
--  attribute mark_debug                 : string;
--  attribute mark_debug of eeprom_rdy      : signal is "true";
--  attribute mark_debug of eeprom_rdy_last : signal is "true";
--  attribute mark_debug of startup_enb     : signal is "true";
--  attribute mark_debug of startup_fault   : signal is "true";
--  attribute mark_debug of startup_dly_cnt : signal is "true";
--  attribute mark_debug of startup_delay   : signal is "true";
 
 
 
begin  

 


-- startup delay counter.   Fault besocm until this counter goes to zero 
process(clk)
  begin
    if (rising_edge(clk)) then
      if (reset = '1') then
        startup_dly_cnt <= 32d"0"; 
        startup_fault <= '1'; 
        startup_enb <= '0';    
      else
        --eeprom_rdy_last <= eeprom_rdy;
        --if (eeprom_rdy = '1' and eeprom_rdy_last = '0') then
        --acis_keylock: 1=run mode, 0=edit mode
        --trig startup delay when key goes to run mode
        acis_keylock_last <= acis_keylock;
        if (acis_keylock = '1' and acis_keylock_last = '0') then
           startup_enb <= '1';
           startup_fault <= '1';
           startup_dly_cnt <= startup_delay;
        end if;
           
        if (accum_update = '1' and startup_enb = '1') then
           if (startup_dly_cnt = 32d"0") then
             startup_fault <= '0';
             startup_enb <= '0';
           else
             startup_dly_cnt <= startup_dly_cnt - 1; 
           end if;
        end if;
      end if;
    end if;
  end process;
  
  


  
end behv;
