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
