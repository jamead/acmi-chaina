library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


use std.textio.all;

library UNISIM;
use UNISIM.VComponents.all;

entity readadc_ltc2107 is
 generic (
    SIM_MODE            : integer := 0
  );
  port (
   adc_clk_p   : in  std_logic;                  
   adc_clk_n   : in  std_logic;
   reset       : in std_logic;                     
   adc_data_p  : in std_logic_vector(7 downto 0);
   adc_data_n  : in std_logic_vector(7 downto 0); 
   adc_of_p    : in std_logic;
   adc_of_n    : in std_logic;
   adc_clk     : out std_logic;
   adc_data    : out std_logic_vector(15 downto 0);
   adc_sat     : out std_logic              
  );    
end readadc_ltc2107;


architecture behv of readadc_ltc2107 is

   signal adc_data_even : std_logic_vector (7 downto 0);
   signal adc_data_odd  : std_logic_vector (7 downto 0);
   signal adc_data_in   : std_logic_vector(7 downto 0);
   signal adc_data_ob   : std_logic_vector(15 downto 0);
   signal adc_clk_i     : std_logic;
   signal adc_clk_dlyd  : std_logic;
   signal adc_clk_o     : std_logic;
   signal adc_of        : std_logic;
   signal sample_cnt    : integer := 0;
   signal idly_rdy      : std_logic;
  
   attribute mark_debug                 : string;
   attribute mark_debug of adc_data      : signal is "true";
   
  
  
begin  

adc_sat <= adc_of;

adc_clk_inst  : IBUFDS  port map (O => adc_clk_i, I => adc_clk_p, IB => adc_clk_n); 
adc_clk_bufg  : BUFG    port map (O => adc_clk, I => adc_clk_i);

gen_adcdata: for i in 0 to 7 generate
begin
  adc_data_inst  : IBUFDS  port map (O => adc_data_in(i), I => adc_data_p(i), IB => adc_data_n(i)); 
end generate;

adc_of_inst  : IBUFDS  port map (O => adc_of, I => adc_of_p, IB => adc_of_n); 


adcdata_syn: if (SIM_MODE = 0) generate 
lat_data: process(adc_clk)
begin
   if (rising_edge(adc_clk)) then
     adc_data <= adc_data_ob;
   end if;
end process;
end generate;


ddr_high_inst : process(adc_clk)
begin
  if (falling_edge(adc_clk)) then
      adc_data_odd <= adc_data_in;
  end if;
end process;

 

ddr_low_inst : process(adc_clk)
begin
  if (rising_edge(adc_clk)) then
     adc_data_even <= adc_data_in;
     if (reset = '1') then 
         adc_data_ob <= (others => '0');
     else
         adc_data_ob <=   adc_data_odd(7) & adc_data_even(7) & adc_data_odd(6) & adc_data_even(6) &
                          adc_data_odd(5) & adc_data_even(5) & adc_data_odd(4) & adc_data_even(4) &
                          adc_data_odd(3) & adc_data_even(3) & adc_data_odd(2) & adc_data_even(2) &
                          adc_data_odd(1) & adc_data_even(1) & adc_data_odd(0) & adc_data_even(0);  
     end if;
  end if;
end process;







adcdata_sim: if (SIM_MODE = 1) generate read_adc_data: 
  process(adc_clk)
   --file adc_vector   : text open read_mode is "../sim/wvfm_data_4-15-22.txt";  
    file adc_vector   : text open read_mode is "/home/mead/aps/besocm/firmware/besocm_artix_v3/sim/wvfm_data_4-15-22.txt";
    --file adc_vector   : text open read_mode is "/home/mead/aps/besocm/firmware/revA_brd/besocm_artix_v3/sim/wvfm_data_4-15-22";
    variable row       : line;
    variable adc_raw  : integer;

    --variable sampnum   : integer;
  
    begin
      if (rising_edge(adc_clk))  then
        sample_cnt <= sample_cnt + 1;
        if (sample_cnt > 0) and (sample_cnt < 5000) then
           readline(adc_vector,row);
           --read(row,sampnum);
           read(row,adc_raw);
           adc_data <= x"8000" xor std_logic_vector(to_signed(adc_raw,16)); 
        else
           adc_data <= x"8000";
        end if;
      end if;
end process;
end generate;



  
end behv;
