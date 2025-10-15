library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

entity artix_spi is
  port (
   clk         : in  std_logic;                  
   reset  	   : in  std_logic;                     
   we		   : in  std_logic;
   addr        : in std_logic_vector(31 downto 0);
   wrdata	   : in  std_logic_vector(31 downto 0);
   rddata      : out std_logic_vector(31 downto 0);
   rw          : in std_logic;
   sclk        : out std_logic;                   
   din 	       : in std_logic;
   dout        : out std_logic;
   cs          : out std_logic                 
  );    
end artix_spi;

architecture behv of artix_spi is

  type     state_type is (IDLE, CLKP1, CLKP2, SETSYNC); 
  signal   state            : state_type  := idle;
  signal   sys_clk          : std_logic;                                                                              
  signal   treg             : std_logic_vector(63 downto 0)  := 64d"0";                                                                                                                                    
  signal   bcnt             : integer range 0 to 64 := 0;          
  signal   xfer_done        : std_logic := '0';                      
   
  signal clk_cnt            : std_logic_vector(7 downto 0) := 8d"0";  
 
  signal we_lat				: std_logic := '0';
  signal we_lat_clr			: std_logic := '0';
  
  signal spi_data			: std_logic_vector(63 downto 0) := 64d"0";
  signal spi_rw             : std_logic;
  
  signal clk_enb            : std_logic  := '1';
  
  signal rreg               : std_logic_vector(31 downto 0) := 32d"0";
  
  
  
   attribute mark_debug                 : string;
   attribute mark_debug of rreg      : signal is "true";
   attribute mark_debug of clk_cnt     : signal is "true";
   attribute mark_debug of clk_enb  : signal is "true";  
  
  
begin  


-- initiate spi command on we input
process (clk, reset)
   begin
     if (we_lat_clr = '1') then
	     spi_data <= (others => '0');
	     we_lat <= '0';
     elsif (clk'event and clk = '1') then
		   if (we = '1') then
	           we_lat <= '1';
	           spi_data(63)   <= rw;
			   spi_data(31 downto 0) <= wrdata;
			   spi_data(62 downto 32) <= addr(30 downto 0); 
	    	end if;
     end if;
end process;


-- spi transfer
process (clk, reset)
  begin  
    if (clk'event and clk = '1') then  
      if (clk_enb = '1') then
        case state is
          when IDLE =>  
            dout   <= '0';   
            sclk  <= '0';
            cs  <= '1';
            xfer_done <= '0';
            we_lat_clr <= '0';
            if (we_lat = '1') then
                cs <= '0';
                treg <= spi_data;  
                bcnt <= 63;  
                state <= CLKP1;
            end if;

          when CLKP1 =>     -- CLKP1 clock phase LOW
			sclk  <= '0';
            state <= CLKP2;
			treg <= treg(62 downto 0) & '0';
            dout <= treg(63);

          when CLKP2 =>     -- CLKP1 clock phase 2
            sclk <= '1';
            rreg <= rreg(30 downto 0) & din;
            if (bcnt = 0) then
			   xfer_done <= '1';
               we_lat_clr <= '1';				
               state <= SETSYNC;
            else
               bcnt <= bcnt - 1;
               state <= CLKP1;
		    end if;
 
          when SETSYNC => 
            rddata <= rreg;
            sclk <= '0';
            cs <= '1';
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
       if clk_cnt = 8d"2" then
         clk_cnt <= 8d"0";
         clk_enb <= '1';
       else
         clk_cnt <= clk_cnt + 1;
         clk_enb <= '0';
       end if; 
    end if;
end process; 




  
end behv;
