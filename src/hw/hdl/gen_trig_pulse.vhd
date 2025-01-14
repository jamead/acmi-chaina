library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



library UNISIM;
use UNISIM.VComponents.all;

entity gen_trig_pulse is
  port (
   clk          : in  std_logic;
   trig         : in std_logic;                 
   pulse        : out std_logic              
  );    
end gen_trig_pulse;


architecture behv of gen_trig_pulse is
    

  signal sync_trig    : std_logic_vector(3 downto 0);
  
  
begin  


process (clk)
  begin
    if (rising_edge(clk)) then
       sync_trig(0) <= trig;
       sync_trig(1) <= sync_trig(0);
       sync_trig(2) <= sync_trig(1);
       sync_trig(3) <= sync_trig(2);
    end if;
end process;

 
 -- generate the pulse
process (clk)
  begin  
    if (rising_edge(clk)) then
      if (sync_trig(3) = '1' and sync_trig(2) = '0') then
        pulse <= '1';
      else
        pulse <= '0';
      end if;
    end if;
  end process;


  
end behv;
