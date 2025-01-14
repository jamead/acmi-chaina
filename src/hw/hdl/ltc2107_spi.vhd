library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

entity ltc2107_spi is
  port (
   clk         : in  std_logic;                  
   reset  	   : in  std_logic;                     
   sclk        : out std_logic;                   
   din 	       : out std_logic;
   dout        : in  std_logic;
   sync        : out std_logic                 
  );    
end ltc2107_spi;

architecture behv of ltc2107_spi is

  type   state_type is (IDLE, CLKP1, CLKP2, SETSYNC); 
  signal state            : state_type  := idle;                                                                             
  signal treg             : std_logic_vector(15 downto 0)  := 16d"0";                                                                                                                                    
  signal bcnt             : integer range 0 to 24 := 0;     
  signal rddata           : std_logic_vector(7 downto 0);     
                   
  signal clk_cnt            : std_logic_vector(7 downto 0) := 8d"0";    
  signal clk_enb            : std_logic  := '1';
  
  signal rreg               : std_logic_vector(7 downto 0) := 8d"0";
  
  signal prev_reset         : std_logic;
  
  
begin  



-- spi transfer
process (clk, reset)
  begin  
    if (clk'event and clk = '1') then  
      if (clk_enb = '1') then
        case state is
          when IDLE =>  
            din   <= '0';   
            sclk  <= '0';
            sync  <= '1';
            prev_reset <= reset;
            if (prev_reset = '1') and (reset = '0') then
            --if (reset = '0') then
                sync <= '0';
                treg <= x"0301"; --x"0303";  --reset adc, see datasheet  
                bcnt <= 15;  
                state <= CLKP1;
            end if;

          when CLKP1 =>     -- CLKP1 clock phase LOW
			sclk  <= '0';
            state <= CLKP2;
			treg <= treg(14 downto 0) & '0';
            din <= treg(15);

          when CLKP2 =>     -- CLKP1 clock phase 2
            sclk <= '1';
            rreg <= rreg(6 downto 0) & dout;
            if (bcnt = 0) then			
               state <= SETSYNC;
            else
               bcnt <= bcnt - 1;
               state <= CLKP1;
		    end if;
 
          when SETSYNC => 
            rddata <= rreg;
            sclk <= '0';
            sync <= '1';
            state <= idle;
            
    
          when others =>
            state <= IDLE;
      end case;
    end if;
  end if;
end process;



-- generate 1MHz clock enable from 100MHz system clock
clkdivide : process(clk, reset)
  begin
    if (rising_edge(clk)) then
       if clk_cnt = 8d"100" then
         clk_cnt <= 8d"0";
         clk_enb <= '1';
       else
         clk_cnt <= clk_cnt + 1;
         clk_enb <= '0';
       end if; 
    end if;
end process; 




  
end behv;
