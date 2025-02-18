library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    generic (
        CLOCK_FREQ : integer := 200_000_000; -- System clock frequency (Hz)
        DEBOUNCE_TIME : integer := 10_000  -- Debounce time in clock cycles
    );
    port (
        clk     : in std_logic;
        reset   : in std_logic;
        switch  : in std_logic;
        clean   : out std_logic
    );
end debounce;

architecture behv of debounce is
    signal count       : integer range 0 to DEBOUNCE_TIME := 0;
    signal switch_reg  : std_logic := '0';
    signal stable      : std_logic := '0';
begin
    process (clk, reset)
    begin
        if reset = '1' then
            count <= 0;
            stable <= '0';
        elsif rising_edge(clk) then
            if switch = switch_reg then
                if count < DEBOUNCE_TIME then
                    count <= count + 1;
                else
                    stable <= switch_reg;
                end if;
            else
                count <= 0;
            end if;
            switch_reg <= switch;
        end if;
    end process;
    
    clean <= stable;
end behv;



--------------------------------------------------------------------------------
--
--   FileName:         debounce.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Version 17.0.0 Build 595 SJ Lite Edition
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 2.0 6/28/2019 Scott Larson
--     Added asynchronous active-low reset
--     Made stable time higher resolution and simpler to specify
--   Version 1.0 3/26/2012 Scott Larson
--     Initial Public Release
--
--------------------------------------------------------------------------------

--LIBRARY ieee;
--USE ieee.std_logic_1164.all;

--ENTITY debounce IS
--  GENERIC(
--    clk_freq    : INTEGER := 200_000_000;  --system clock frequency in Hz
--    stable_time : INTEGER := 10);         --time button must remain stable in ms
--  PORT(
--    clk     : IN  STD_LOGIC;  --input clock
--    reset   : IN  STD_LOGIC;  --asynchronous active low reset
--    button  : IN  STD_LOGIC;  --input signal to be debounced
--    result  : OUT STD_LOGIC); --debounced signal
--END debounce;

--ARCHITECTURE logic OF debounce IS
--  SIGNAL flipflops   : STD_LOGIC_VECTOR(1 DOWNTO 0); --input flip flops
--  SIGNAL counter_set : STD_LOGIC;                    --sync reset to zero
--BEGIN

--  counter_set <= flipflops(0) xor flipflops(1);  --determine when to start/reset counter
  
--  PROCESS(clk, reset)
--    VARIABLE count :  INTEGER RANGE 0 TO clk_freq*stable_time/1000;  --counter for timing
--  BEGIN
--    IF(reset = '1') THEN                        --reset
--      flipflops(1 DOWNTO 0) <= "00";                 --clear input flipflops
--      result <= '0';                                 --clear result register
--    ELSIF(clk'EVENT and clk = '1') THEN           --rising clock edge
--      flipflops(0) <= button;                        --store button value in 1st flipflop
--      flipflops(1) <= flipflops(0);                  --store 1st flipflop value in 2nd flipflop
--      If(counter_set = '1') THEN                     --reset counter because input is changing
--        count := 0;                                    --clear the counter
--      ELSIF(count < clk_freq*stable_time/1000) THEN  --stable input time is not yet met
--        count := count + 1;                            --increment counter
--      ELSE                                           --stable input time is met
--        result <= flipflops(1);                        --output the stable value
--      END IF;    
--    END IF;
--  END PROCESS;
  
--END logic;
