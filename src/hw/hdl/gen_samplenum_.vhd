library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



library UNISIM;
use UNISIM.VComponents.all;

entity gen_samplenum is
  port (
   clk          : in  std_logic;
   window       : in std_logic; 
   samplenum    : out std_logic_vector(15 downto 0) := 32d"0";
           
  );    
end gen_samplenum;


architecture behv of gen_samplenum is
    
  
begin  


 -- generate the pulse
process (clk)
  begin  
    if (rising_edge(clk)) then
      if (window = '1') then
        samplenum <= samplenum + 1;
      else
        samplenum <= 32d"0";
      end if;
  
     end if; 
  end process;


  
end behv;
