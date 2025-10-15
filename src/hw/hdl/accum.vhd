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


entity accum is
  port (
    clk                : in std_logic;
    rst                : in std_logic;
    beam_detect_window : in std_logic;
    accum_update       : in std_logic;
    sample             : in std_logic_vector(31 downto 0);
    accum              : out std_logic_vector(31 downto 0)
);
end accum;      


    
    
architecture behv of accum is
  constant BUFLEN   : INTEGER := 7200; --1800;  --120; 15min = 900 seconds * 2Hz.;
  type    sample_buf_type is array(0 to BUFLEN) of std_logic_vector(31 downto 0); 
  signal  sample_buf     : sample_buf_type  := (others=> (others => '0'));

 
  signal end_sample              : std_logic_vector(31 downto 0);
  signal wraddr                  : INTEGER RANGE 0 to BUFLEN;
  signal rdaddr                  : INTEGER RANGE 0 to BUFLEN;
  signal buffull                 : std_logic;
  signal bufcnt                  : INTEGER RANGE 0 to BUFLEN;
  signal prev_beam_detect_window : std_logic := '0'; 
  signal trig                    : std_logic;
  signal beam_valid              : std_logic;
  signal validated_sample        : std_logic_vector(31 downto 0) := 32d"0";
 
 
   --debug signals (connect to ila)
   attribute mark_debug                 : string;
   attribute mark_debug of sample: signal is "true";
   attribute mark_debug of validated_sample: signal is "true";
   attribute mark_debug of accum: signal is "true";
   attribute mark_debug of accum_update: signal is "true";
   attribute mark_debug of trig: signal is "true";
   attribute mark_debug of buffull: signal is "true";
   attribute mark_debug of bufcnt : signal is "true";
   attribute mark_debug of end_sample: signal is "true";
   attribute mark_debug of wraddr: signal is "true";
   attribute mark_debug of rdaddr: signal is "true";
   attribute mark_debug of beam_detect_window: signal is "true";
   attribute mark_debug of beam_valid: signal is "true";
   
 
 
begin  

--generate a trigger at the end of of beam detect window
process(clk, rst)
  begin
    if (rising_edge(clk)) then
      prev_beam_detect_window <= beam_detect_window;
      if (prev_beam_detect_window = '1' and beam_detect_window = '0') then
        trig <= '1';
      else 
        trig <= '0';
      end if;
    end if;
end process;


-- check if we got a beam detect window since last accum update
process(clk)
  begin
    if (rising_edge(clk)) then
      if (accum_update = '1') then
        beam_valid <= '0';
        if (beam_valid = '1') then
          validated_sample <= sample;
        else
          validated_sample <= 32d"0";
        end if;
      end if;
      
      if (trig = '1') then
        beam_valid <= '1';
      end if;
    end if;
 end process;      




-- don't allow outputs until sample buffer is full
process (clk, rst)
  begin
    if (rst = '1') then
      buffull <= '0';
      bufcnt <= 0;
    elsif (clk'event and clk = '1') then
      if (accum_update = '1') then 
        if (bufcnt = BUFLEN) then
          buffull <= '1';
        else
          bufcnt <= bufcnt + 1;
        end if;
      end if;
    end if;
end process;


-- do the accumulation
process (clk, rst)
  begin
    if (rst = '1') then
      accum <= (others => '0');
    elsif (clk'event and clk = '1') then
      if (accum_update = '1') then
        if (buffull = '0') then
          accum <= accum + validated_sample;
        else
          accum <=  accum + validated_sample - end_sample;
        end if;
      end if;
    end if;
end process;


-- write into / read from dpram
process (clk, rst)
  begin
    if (rst = '1') then
      wraddr <= 0;
      rdaddr <= 0;
    elsif (clk'event and clk = '1') then
      if (accum_update = '1') then
        wraddr <= rdaddr;
        sample_buf(wraddr) <= validated_sample;
        end_sample <= sample_buf(rdaddr);

        if (rdaddr = BUFLEN) then
          rdaddr <= 0;
        else 
          rdaddr <= rdaddr + 1;
        end if;
      end if;
    end if;
end process;
          

  
end behv;
