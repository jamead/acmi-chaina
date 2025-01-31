----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/31/2025 01:58:19 PM
-- Design Name: 
-- Module Name: crc_tb - behv
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


library work;
use work.acmi_package.ALL;

entity crc_tb is
end crc_tb;

architecture behv of crc_tb is


  signal clk          : std_logic;
  signal reset        : std_logic;
  signal eeprom_data  : eeprom_data_type;
  signal crc_result   : std_logic_vector(31 downto 0);

begin


-- checks CRC of eeprom settings in FPGA at 1Hz
crc_check_1hz: entity work.crc_compute
  port map (
    clk => clk,
    reset => reset,
    eeprom_data => eeprom_data,
    crc_calc => crc_result
);



process
  begin 
    clk <= '0';
    wait for 5 ns;
    clk <= '1'; 
    wait for 5 ns;
end process;



process
  begin 
    reset <= '1';
    for i in 0 to 200 loop
      eeprom_data(i) <= std_logic_vector(to_unsigned(i+1, 8));
    end loop;
    
    wait for 1000 ns;
    reset <= '0'; 
    wait for 100 ms;
end process;




end behv;
