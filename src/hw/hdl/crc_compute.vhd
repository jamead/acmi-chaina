-------------------------------------------------------------------------------
-- Title         : crc_compute
-------------------------------------------------------------------------------

-- 10/11/2022: created.
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.acmi_package.ALL;


entity crc_compute is 
  port (
    clk          	    : in std_logic;  
    reset               : in std_logic;
    eeprom_data         : in eeprom_data_type;
    crc_calc            : out std_logic_vector(31 downto 0)
 
  );    
end crc_compute;

architecture behv of crc_compute is

  type     state_type is (IDLE, CHECK_CRC, LATCH_CRC); 
  signal   state            : state_type;


  signal clk_cnt          : std_logic_vector(31 downto 0);
  signal crc_check        : std_logic;
  signal rddata           : std_logic_vector(7 downto 0);
  signal crc_en           : std_logic;
  signal crc_rst          : std_logic;
  signal bytes_read       : INTEGER RANGE 0 to 255;
  signal crc_out          : std_logic_vector(31 downto 0);
  


   --debug signals (connect to ila)
   attribute mark_debug                 : string;
   attribute mark_debug of clk_cnt: signal is "true";   
   attribute mark_debug of crc_check: signal is "true";
   attribute mark_debug of rddata: signal is "true";
   attribute mark_debug of crc_en: signal is "true";
   attribute mark_debug of crc_rst: signal is "true";             
   attribute mark_debug of bytes_read: signal is "true";
   attribute mark_debug of crc_out: signal is "true";
   attribute mark_debug of crc_calc: signal is "true";


begin  

 
-- generate 1Hz crc check signal
process(clk)
  begin
    if (rising_edge(clk)) then
      if (reset = '1') then
        clk_cnt <= 32d"0"; 
        crc_check <= '0';
      else
        if (clk_cnt >= 32d"200000000") then
          crc_check <= '1';
          clk_cnt <= 32d"0";
        else
          crc_check <= '0';
          clk_cnt <= clk_cnt + 1;
        end if;
      end if;
    end if;
  end process;  



process(clk)
  begin
    if (rising_edge(clk)) then
      if (reset = '1') then
        crc_en <= '0';
        crc_rst <= '0';
        state <= idle;
      else
        case state is
          when IDLE =>
            crc_rst <= '1';
            if (crc_check = '1') then
              crc_rst <= '0';
              state <= check_crc;
              bytes_read <= 0;
            end if;
                     
          when CHECK_CRC => 
            crc_en <= '1';
            bytes_read <= bytes_read + 1;
            rddata <= eeprom_data(bytes_read);
            if (bytes_read >= EEPROM_LEN-4) then
              crc_en <= '0';  --don't include CRC in file for calc.
              state <= latch_crc;
            end if;
          
          when LATCH_CRC =>
            crc_calc <= crc_out;
            state <= idle; 
            
          when others => 
            state <= idle; 
            
         end case;
       end if;
    end if;
end process;



crc32gen: entity work.crc 
  port map ( 
    data_in => rddata,
    crc_en => crc_en, 
    rst => crc_rst,
    clk => clk, 
    crc_out => crc_out 
);




  
  
end behv;  