library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.acmi_package.all;

entity rx_backend_data is
  port (
   clk          : in std_logic;  
   gtp_rx_clk   : in std_logic;
   rst          : in std_logic; 
   acis_keylock : in std_logic;             
   gtp_rx_data  : in std_logic_vector(31 downto 0);
   trig         : out std_logic;
   params       : out cntrl_parameters_type           
  );    
end rx_backend_data;

architecture behv of rx_backend_data is

  
   type     state_type is (IDLE, GET_ADDR, GET_DATA, DONE, HOLD); 
   signal   state            : state_type;

   signal addr               : std_logic_vector(31 downto 0);
   signal data               : std_logic_vector(31 downto 0);
   signal strb               : std_logic;
   signal sync_strb          : std_logic_vector(2 downto 0);
  
  
   attribute mark_debug                  : string;
   attribute mark_debug of addr: signal is "true";
   attribute mark_debug of data: signal is "true";
   attribute mark_debug of state: signal is "true";  
   attribute mark_debug of strb: signal is "true";
   attribute mark_debug of sync_strb: signal is "true";
   attribute mark_debug of params: signal is "true";
  
  
begin  

--acis_keylock: 1=run mode, 0=edit mode
      
      
-- gtp data
get_gtp_data: process(gtp_rx_clk)
  begin
    if (rising_edge(gtp_rx_clk)) then
      if (rst = '1') then
        state <= idle;
      else
        case state is  
          when IDLE =>
            strb <= '0';
            if (gtp_rx_data = x"ba5eba11") then
              state <= get_addr;
            end if;          
          when GET_ADDR =>
            addr <= gtp_rx_data;
            state <= get_data;      
          when GET_DATA =>
            data <= gtp_rx_data;
            state <= done;      
          when DONE =>
            strb <= '1';
            state <= hold;  
          when HOLD =>
            state <= idle; 
          when OTHERS => 
            state <= idle; 
        end case; 
      end if;
    end if;
end process;                                   


--sync strb to adc clock domain
process(clk)
  begin
    if (rising_edge(clk)) then 
      sync_strb(0) <= strb;
      sync_strb(1) <= sync_strb(0); 
      sync_strb(2) <= sync_strb(1); 
    end if;
end process; 



--decode data
decode_data: process(clk)
  begin
    if (rising_edge(clk)) then
      if (rst = '1') then
        params.eeprom_trig     <= '0';
        params.eeprom_wrdata   <= 32d"0"; 
        params.eeprom_readall  <= '0';  
        params.trig_out_delay  <= 32d"0";
        params.trig_out_enable <= '0';    
          
      --acis_keylock: 1=run mode, 0=edit mode
      elsif (sync_strb(2) = '0') and (sync_strb(1) = '1') then 
        case addr(7 downto 0) is
          when x"00" =>   trig                        <= data(0);
          when x"40" =>   params.accum_reset          <= data(0); 
          when x"41" =>   params.trig_out_delay       <= data;
          when x"42" =>   params.trig_out_enable      <= data(0);
          when x"50" =>   params.eeprom_trig          <= data(0);
          when x"51" =>   params.eeprom_wrdata        <= data;   
          when x"52" =>   params.eeprom_readall       <= data(0);                    

          when others => null;
        end case;
      else
        trig <= '0';
        params.eeprom_trig <= '0';
        params.eeprom_readall <= '0';
      end if;
    end if;
end process;                                   





  
end behv;
