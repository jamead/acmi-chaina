----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2021 01:42:56 PM
-- Design Name: 
-- Module Name: resync - behv
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
 

library work;
use work.xbpm_package.ALL;

entity resync is
  port ( 
    clka       : in std_logic;
    clkb       : in std_logic;
    trig_a     : in std_logic;
    trig_b     : out std_logic
  );
end resync;

architecture behv of resync is

  signal trig_a_stretch    : std_logic := '0';
  signal trig_a_cnt        : std_logic_vector(3 downto 0)  := x"0";
  signal trig_sync_reg     : std_logic_vector(2 downto 0)  := "000";
  signal prev_trig_a       : std_logic := '0';

begin

process(clka)
  begin 
    if (rising_edge(clka)) then
      prev_trig_a <= trig_a;
      if (trig_a = '1' and prev_trig_a = '0') then
        trig_a_stretch <= '1';
        trig_a_cnt <= x"0";
      end if;
      if (trig_a_stretch = '1') then
        if (trig_a_cnt = x"5") then
          trig_a_stretch <= '0';
        else
          trig_a_cnt <= trig_a_cnt + 1;
        end if;
      end if;
    end if;
end process;


process(clkb)
  begin
    if (rising_edge(clkb)) then 
      trig_sync_reg(0) <= trig_a_stretch;
      trig_sync_reg(1) <= trig_sync_reg(0);
      trig_sync_reg(2) <= trig_sync_reg(1);
      if (trig_sync_reg(2) = '0') and (trig_sync_reg(1) = '1') then
        trig_b <= '1';
      else
        trig_b <= '0';
      end if;
    end if;
end process; 




end behv;
