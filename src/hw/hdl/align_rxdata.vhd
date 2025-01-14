----------------------------------------------------------------------------------
-- Company:  Brookhaven National Lab
-- Engineer: Joseph Mead
-- 
-- Create Date: 09/19/2019 10:25:22 AM
-- Design Name: 
-- Module Name: accum.vhd
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:   
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;


entity align_rxdata is
  port (
    clk                : in std_logic;
    rst                : in std_logic;
    data_in            : in std_logic_vector(31 downto 0);
    charisk_in         : in std_logic_vector(3 downto 0);
    data_out           : out std_logic_vector(31 downto 0)

);
end align_rxdata;      


    
    
architecture behv of align_rxdata is


  type     state_type is (NOT_LOCKED, ALIGNED_SWAPPED, ALIGNED); 
  signal   state            : state_type  := not_locked;

 
  signal data_in_prev           : std_logic_vector(31 downto 0);
   
 
 
begin  




process (clk)
begin
  if (rising_edge(clk)) then
    data_in_prev <= data_in;
  end if;
end process;

--must manually align to a 4 byte boundary
process (clk)
begin
  if (rising_edge(clk)) then
    if (rst = '0') then
      state <= NOT_LOCKED;
      data_out <= 32d"0";
    else
      case state is 
        when NOT_LOCKED => 
           data_out <= 32d"0";
           if (data_in = x"50bc5251" and charisk_in = x"4") then
              --alignment locked on high byte, must swap words
              state <= aligned_swapped;
           end if;
           
           if (data_in = x"525150bc" and charisk_in = x"1") then
              --alignment locked on low byte, no swapping
              state <= aligned; 
           end if;
  
        when ALIGNED =>
           data_out <= data_in;
           if (charisk_in = x"1" or charisk_in = x"0") then
              state <= aligned;
           else
              state <= not_locked;
           end if;
           
        when ALIGNED_SWAPPED =>  
           data_out <= data_in(15 downto 0) & data_in_prev(31 downto 16);
           if (charisk_in = x"4" or charisk_in = x"0") then
              state <= aligned_swapped;
           else
              state <= not_locked;
           end if;
           
      end case;
    end if;
  end if;
end process;

  
end behv;
