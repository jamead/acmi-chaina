library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.acmi_package.ALL;


entity eeprom_spi is
  port (
   clk         : in std_logic;                  
   reset  	   : in std_logic; 
   trig        : in std_logic;
   command     : in std_logic_vector(31 downto 0);        
   sclk        : out std_logic;                   
   din 	       : out std_logic;
   dout        : in std_logic;
   csn         : out std_logic;
   holdn       : out std_logic;
   rddata      : out std_logic_vector;
   xfer_done   : out std_logic                
  );    
end eeprom_spi;

architecture behv of eeprom_spi is
  --opcodes defined in CAT25320 data sheet
  constant RDSR            : std_logic_vector(7 downto 0) := x"05";
  constant WRSR            : std_logic_vector(7 downto 0) := x"01";
  constant WREN            : std_logic_vector(7 downto 0) := x"06";
  constant WRDI            : std_logic_vector(7 downto 0) := x"04";
  constant READ            : std_logic_vector(7 downto 0) := x"03";
  constant WRITE           : std_logic_vector(7 downto 0) := x"02";    
  
  type   state_type is (IDLE, CLKP1, CLKP2, SETSYNC); 
  signal state            : state_type  := idle;                                                                             
  signal treg             : std_logic_vector(31 downto 0)  := 32d"0";                                                                                                                                    
  signal bcnt             : integer range 0 to 32 := 0;     
  --signal rddata           : std_logic_vector(7 downto 0);     
                   
  signal clk_cnt            : std_logic_vector(7 downto 0) := 8d"0";    
  signal clk_enb            : std_logic  := '1';
  
  signal rreg               : std_logic_vector(7 downto 0) := 8d"0";
  signal go                 : std_logic;
  signal trig_clr           : std_logic;
  signal opcode             : std_logic_vector(7 downto 0);
  
  
  attribute mark_debug                  : string;
  attribute mark_debug of trig : signal is "true";
  attribute mark_debug of trig_clr : signal is "true";  
  attribute mark_debug of sclk : signal is "true";
  attribute mark_debug of din : signal is "true";
  attribute mark_debug of dout : signal is "true";
  attribute mark_debug of csn : signal is "true";
  attribute mark_debug of rddata : signal is "true";
  attribute mark_debug of rreg : signal is "true";
  attribute mark_debug of opcode: signal is "true";
  
  
  
  
  
begin  

holdn <= '1';



process (clk)
begin
  if (rising_edge(clk)) then
    if (trig_clr = '1') or (reset = '1') then
      opcode <= x"00";
      go <= '0';
    else
      if (trig = '1') then
        opcode <= command(31 downto 24);
        go <= '1';
      end if;
    end if;
  end if;
end process;


-- spi transfer
process (clk, reset)
  begin  
    if (rising_edge(clk)) then  
      if (clk_enb = '1') then
        case state is
          when IDLE =>  
            xfer_done <= '0';
            trig_clr <= '0';
            din   <= '0';   
            sclk  <= '0';
            csn  <= '1';
            if (go = '1') then
                treg <= command;  
                if (opcode = RDSR) or (opcode = WRSR) then
                  csn <= '0';
                  state <= clkp1;
                  bcnt <= 15;
                elsif (opcode = WREN) or (opcode = WRDI) then
                  csn <= '0';
                  state <= clkp1;
                  bcnt <= 7;
                elsif (opcode = READ) or (opcode = WRITE) then
                  csn <= '0';
                  state <= clkp1;
                  bcnt <= 31;
                else
                  state <= idle;
                  trig_clr <= '1';
                end if;
            end if;

          when CLKP1 =>     -- CLKP1 clock phase LOW
			sclk  <= '0';
            state <= CLKP2;
			treg <= treg(30 downto 0) & '0';
            din <= treg(31);

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
            trig_clr <= '1';
            rddata <= rreg;
            xfer_done <= '1';
            sclk <= '0';
            din <= '0';
            state <= idle;
            
            
            
    
          when others =>
            state <= IDLE;
      end case;
    end if;
  end if;
end process;



-- generate 1MHz clock enable from 200MHz system clock
clkdivide : process(clk, reset)
  begin
    if (rising_edge(clk)) then
       if clk_cnt = 8d"50" then
         clk_cnt <= 8d"0";
         clk_enb <= '1';
       else
         clk_cnt <= clk_cnt + 1;
         clk_enb <= '0';
       end if; 
    end if;
end process; 




  
end behv;
