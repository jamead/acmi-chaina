library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.acmi_package.all;

entity pzed_spi is
  port (
   clk          : in std_logic;  
   rst          : in std_logic; 
   acis_keylock : in std_logic;               
   sclk         : in std_logic;                   
   din 	        : in std_logic;
   dout         : out std_logic;
   csn          : in std_logic;
   spi_xfer     : out std_logic;
   soft_trig    : out std_logic;
   params       : out cntrl_parameters_type;
   pulse_dly    : out pulse_cnfg_type;
   pulse_hi     : out pulse_cnfg_type             
  );    
end pzed_spi;

architecture behv of pzed_spi is


  
   signal bitnum             : INTEGER RANGE 64 downto 0;
   signal spi_data           : std_logic_vector(31 downto 0);
   signal spi_addr           : std_logic_vector(31 downto 0);
   signal spi_rw             : std_logic;
   signal spi_shiftdata      : std_logic_vector(63 downto 0);
   signal rddata             : std_logic_vector(63 downto 0) := 64d"0";
   signal prev_csn           : std_logic;
   signal sync_csn           : std_logic_vector(2 downto 0);
  
  
--   attribute mark_debug                  : string;
--   attribute mark_debug of spi_data      : signal is "true";
--   attribute mark_debug of spi_addr      : signal is "true";
--   attribute mark_debug of spi_rw        : signal is "true";  
--   attribute mark_debug of spi_shiftdata : signal is "true";
--   attribute mark_debug of bitnum        : signal is "true";
--   attribute mark_debug of spi_xfer      : signal is "true";
--   attribute mark_debug of sync_csn      : signal is "true";
--   attribute mark_debug of params        : signal is "true";
--   attribute mark_debug of soft_trig     : signal is "true";
  
  
begin  


--decode spi data
decode_spi: process(clk)
  begin
    if (rising_edge(clk)) then
      if (rst = '1') then
        params.eeprom_trig     <= '0';
        params.eeprom_wrdata   <= 32d"0"; 
        params.eeprom_readall  <= '0';  
        params.trig_out_delay  <= 32d"0";
        params.trig_out_enable <= '0';    
          
      --acis_keylock: 1=run mode, 0=edit mode
      elsif (spi_xfer = '1') and (spi_rw = '0') then --and (acis_keylock = '0') then
        case spi_addr(7 downto 0) is
          when x"00" =>   soft_trig                   <= spi_data(0);
          --when x"40" =>   params.accum_reset          <= spi_data(0); 
          when x"41" =>   params.trig_out_delay       <= spi_data;
          when x"42" =>   params.trig_out_enable      <= spi_data(0);
          when x"50" =>   params.eeprom_trig          <= spi_data(0);
          when x"51" =>   params.eeprom_wrdata        <= spi_data;   
          when x"52" =>   params.eeprom_readall       <= spi_data(0);                    

          when others => null;
        end case;
      else
        soft_trig <= '0';
        params.eeprom_trig <= '0';
        params.eeprom_readall <= '0';
      end if;
    end if;
end process;                                   



--latch spi data
process (clk)
  begin
    if (rising_edge(clk)) then
      prev_csn <= csn;
      if (sync_csn(2) = '0' and sync_csn(1) = '1') then
        spi_xfer <= '1';
        spi_data <= spi_shiftdata(31 downto 0);
        spi_addr <= '0' & spi_shiftdata(62 downto 32);
        spi_rw <= spi_shiftdata(63);
      else
        spi_xfer <= '0';
        spi_data <= 32d"0";
        spi_addr <= 32d"0";
        spi_rw <= '0';
      end if;
    end if;
end process;




-- spi transfer
process (sclk,csn)
  begin  
    if (csn = '1') then
      bitnum <= 63;    
    elsif (rising_edge(sclk)) then  
      bitnum <= bitnum - 1;
      spi_shiftdata(bitnum) <= din;
      dout <= rddata(bitnum);
    end if;
end process;     


--sync csn to adc clock domain
process(clk)
  begin
    if (rising_edge(clk)) then 
      sync_csn(0) <= csn;
      sync_csn(1) <= sync_csn(0); 
      sync_csn(2) <= sync_csn(1); 
    end if;
end process; 




  
end behv;
