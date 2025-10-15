----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/06/2015 07:14:02 PM
-- Design Name: 
-- Module Name: besocm_artix_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--library work;
--use work.xbpm_package.ALL;


entity top_tb is
end top_tb;

architecture behv of top_tb is


component top is
generic(
    FPGA_VERSION			: integer := 14;
    SIM_MODE				: integer := 1
    );
  port (
   -- adc ltc2107
    adc_spi_cs                : out std_logic;
    adc_spi_sck               : out std_logic;
    adc_spi_sdi               : out std_logic;
    adc_spi_sdo               : in std_logic;
    adc_clk_p                 : in std_logic;
    adc_clk_n                 : in std_logic;
    adc_data_p                : in std_logic_vector(7 downto 0);
    adc_data_n                : in std_logic_vector(7 downto 0);  
    adc_of_p                  : in std_logic;
    adc_of_n                  : in std_logic;
    
    -- trigger input from fiber
    fiber_trig_in             : in std_logic;
    fiber_trig_led            : out std_logic;
    fiber_trig_fp             : out std_logic;    
    
    -- waveform data to picoZed
    waveform_data_p           : out std_logic_vector(15 downto 0);
    waveform_data_n           : out std_logic_vector(15 downto 0);
    waveform_clk_p            : out std_logic;
    waveform_clk_n            : out std_logic;
    waveform_sel_p            : out std_logic;
    waveform_sel_n            : out std_logic;
    waveform_enb_p            : out std_logic;
    waveform_enb_n            : out std_logic;
    
    -- picozed spi
    pzed_spi_sclk             : in std_logic;                    
    pzed_spi_din              : out std_logic; 
    pzed_spi_dout             : in std_logic; 
    pzed_spi_cs               : in std_logic;   
    
    --test pulse signals    
    tp_pulse                  : out std_logic_vector(7 downto 0);

    --test pulse DAC
    dac_tp_data               : out std_logic_vector(13 downto 0);
    dac_tp_clk                : out std_logic;
    
    --front panel debug DAC
    dac_fp_data               : out std_logic_vector(13 downto 0);
    dac_fp_clk                : out std_logic;
    
    --fault input readbacks
    fault_bad_power           : in std_logic;
    fault_no_clock            : in std_logic;
    fault_no_pulse            : in std_logic;
    fault_no_trigger          : in std_logic;
    
    -- fault outputs (active low)
    faultsn                   : out std_logic_vector(11 downto 0);

    --latched fault input readbacks
    faults_lat                : in std_logic_vector(15 downto 0);

    --acis signals readbacks
    acis_faultn               : in std_logic;
    acis_fault_rdbk           : in std_logic;
    acis_reset                : in std_logic;
    acis_force_trip           : in std_logic;
    acis_keylock              : in std_logic;         
    
    --watchdog signals
    watchdog_pulse            : out std_logic;
    watchdog_clock            : out std_logic;
    
    --eeprom
    eeprom_csn                : out std_logic;
    eeprom_sck                : out std_logic;
    eeprom_sdi                : out std_logic;
    eeprom_holdn              : out std_logic;
    eeprom_sdo                : in std_logic;    
    
    
    keylock_detect_led        : out std_logic;

    dbg                       : out std_logic_vector(9 downto 0);
    
    dbg_leds                  : out std_logic_vector(3 downto 0)
    
  );
   
end component;


component artix_spi is
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
end component;





   -- adc ltc2107
    signal adc_spi_cs                : std_logic;
    signal adc_spi_sck               : std_logic;
    signal adc_spi_sdi               : std_logic;
    signal adc_spi_sdo               : std_logic;
    signal adc_clk_p                 : std_logic;
    signal adc_clk_n                 : std_logic;
    signal adc_data_p                : std_logic_vector(7 downto 0);
    signal adc_data_n                : std_logic_vector(7 downto 0);  
    signal adc_of_p                  : std_logic;
    signal adc_of_n                  : std_logic;
    
    -- waveform data to picoZed
    signal waveform_data_p           : std_logic_vector(15 downto 0);
    signal waveform_data_n           : std_logic_vector(15 downto 0);
    signal waveform_clk_p            : std_logic;
    signal waveform_clk_n            : std_logic;
    signal waveform_sel_p            : std_logic;
    signal waveform_sel_n            : std_logic;
    signal waveform_enb_p            : std_logic;
    signal waveform_enb_n            : std_logic;
    
    -- picozed spi
    signal pzed_spi_sclk             : std_logic;                    
    signal pzed_spi_din              : std_logic; 
    signal pzed_spi_dout             : std_logic; 
    signal pzed_spi_cs               : std_logic;   
    
    --test pulse signals    
    signal tp_pulse                  : std_logic_vector(7 downto 0);

    --test pulse DAC
    signal dac_tp_data               : std_logic_vector(13 downto 0);
    signal dac_tp_clk                : std_logic;
    
    --front panel debug DAC
    signal dac_fp_data               : std_logic_vector(13 downto 0);
    signal dac_fp_clk                : std_logic;

    --fault input readbacks
    signal fault_bad_power           : std_logic;
    signal fault_no_clock            : std_logic;
    signal fault_no_pulse            : std_logic;
    signal fault_no_trigger          : std_logic;
    
    -- fault outputs (active low)
    signal faultsn                   : std_logic_vector(11 downto 0);

    --latched fault input readbacks
    signal faults_lat                : std_logic_vector(15 downto 0);

    --acis signals readbacks
    signal acis_faultn               : std_logic;
    signal acis_fault_rdbk           : std_logic;
    signal acis_reset                : std_logic;
    signal acis_force_trip           : std_logic;
    signal acis_keylock              : std_logic;         
    
    --watchdog signals
    signal watchdog_pulse            : std_logic;
    signal watchdog_clock            : std_logic;
    
    signal keylock_detect_led        : std_logic;

    signal eeprom_csn                : std_logic;
    signal eeprom_sck                : std_logic;
    signal eeprom_sdi                : std_logic;
    signal eeprom_holdn              : std_logic;
    signal eeprom_sdo                : std_logic;



    signal dbg                       : std_logic_vector(9 downto 0);
    signal dbg_leds                  : std_logic_vector(3 downto 0);
    
    signal reset                     : std_logic;
    signal pzed_spi_we               : std_logic;
    signal pzed_spi_wrdata           : std_logic_vector(31 downto 0);
    signal pzed_spi_addr             : std_logic_vector(31 downto 0);

    signal fiber_trig_in             : std_logic;
    signal fiber_trig_led            : std_logic;
    signal fiber_trig_fp             : std_logic;   

    signal crc_en                    : std_logic;
    signal crc_out                   : std_logic_vector(31 downto 0);
    signal crc8bit_in                : std_logic_vector(7 downto 0);
    
    signal crc32_en                  : std_logic;
    signal crc32_out                 : std_logic_vector(31 downto 0);
    signal crc32bit_in               : std_logic_vector(31 downto 0);    
 
begin
    
  
dut: top 
  generic map(
    FPGA_VERSION => 4, 
    SIM_MODE => 1
    )
  port map(
   -- adc ltc2107
    adc_spi_cs => adc_spi_cs,
    adc_spi_sck => adc_spi_sck, 
    adc_spi_sdi => adc_spi_sdi, 
    adc_spi_sdo => adc_spi_sdo, 
    adc_clk_p => adc_clk_p, 
    adc_clk_n => adc_clk_n, 
    adc_data_p => adc_data_p, 
    adc_data_n => adc_data_n,   
    adc_of_p => adc_of_p, 
    adc_of_n => adc_of_n, 
    
    fiber_trig_in => fiber_trig_in, 
    fiber_trig_led => fiber_trig_led, 
    fiber_trig_fp => fiber_trig_fp,    
    
    -- waveform data to picoZed
    waveform_data_p => waveform_data_p, 
    waveform_data_n => waveform_data_n, 
    waveform_clk_p => waveform_clk_p,
    waveform_clk_n => waveform_clk_n, 
    waveform_sel_p => waveform_sel_p, 
    waveform_sel_n => waveform_sel_n, 
    waveform_enb_p => waveform_enb_p, 
    waveform_enb_n => waveform_enb_n, 
    
    -- picozed spi
    pzed_spi_sclk => pzed_spi_sclk,                     
    pzed_spi_din => pzed_spi_din,  
    pzed_spi_dout => pzed_spi_dout,  
    pzed_spi_cs => pzed_spi_cs,    
    
    --test pulse signals    
    tp_pulse => tp_pulse, 
    
    --test pulse DAC
    dac_tp_data => dac_tp_data, 
    dac_tp_clk => dac_tp_clk, 
    
    --front panel debug DAC
    dac_fp_data => dac_fp_data, 
    dac_fp_clk => dac_fp_clk, 
    
    --fault input readbacks
    fault_bad_power => fault_bad_power, 
    fault_no_clock => fault_no_clock, 
    fault_no_pulse => fault_no_pulse, 
    fault_no_trigger => fault_no_trigger,
    
    -- fault outputs (active low)
    faultsn => faultsn,

    --latched fault input readbacks
    faults_lat => faults_lat, 

    --acis signals readbacks
    acis_faultn => acis_faultn, 
    acis_fault_rdbk => acis_fault_rdbk, 
    acis_reset => acis_reset, 
    acis_force_trip => acis_force_trip, 
    acis_keylock => acis_keylock,          
    
    --watchdog signals
    watchdog_pulse => watchdog_pulse, 
    watchdog_clock => watchdog_clock, 
    
    --eeprom
    eeprom_csn => eeprom_csn, 
    eeprom_sck => eeprom_sck, 
    eeprom_sdi => eeprom_sdi, 
    eeprom_holdn => eeprom_holdn, 
    eeprom_sdo => eeprom_sdo,    
    
    keylock_detect_led => keylock_detect_led, 

    dbg => dbg, 
    dbg_leds => dbg_leds
    
  );


fe_spi: artix_spi
  port map (
    clk => adc_clk_p,                   
    reset => reset,                      
    we => pzed_spi_we, 
    wrdata => pzed_spi_wrdata, --32d"1", 
    rddata => open, 
    addr => pzed_spi_addr, --x"00000050",
    rw => '0', 
    sclk => pzed_spi_sclk,                    
    din => pzed_spi_din, 
    dout => pzed_spi_dout, 
    cs => pzed_spi_cs                 
  );    



--crc32_8test: entity work.crc 
--  port map ( 
--    data_in => crc8bit_in,
--    crc_en => crc_en, 
--    rst => reset,
--    clk => adc_clk_p, 
--    crc_out => crc_out 
--);


--crc32_32test: entity work.crc 
--  port map ( 
--    data_in => crc32bit_in,
--    crc_en => crc32_en, 
--    rst => reset,
--    clk => adc_clk_p, 
--    crc_out => crc32_out 
--);



-- generate test bench reset
process
    begin 
        adc_spi_sdo <= '0';
        wait for 35 us;
        adc_spi_sdo <= '1';
        wait for 20 us;
        adc_spi_sdo <= '0';
        wait for 1000 us;
end process;



adc_clk_n <= not adc_clk_p;
process
  begin 
    adc_clk_p <= '1';
    wait for 2.5 ns;
    adc_clk_p <= '0'; 
    wait for 2.5 ns;
end process;


adc_data_n <= not adc_data_p;
process
   begin
     wait for 1.25 ns; 
     adc_data_p <= x"00";
     wait for 2.5 ns;
     adc_data_p <= x"FF";
     wait for 2.5 ns;
     adc_data_p <= x"00";
     wait for 2.5 ns;
     adc_data_p <= x"FF";
     wait for 1.25 ns;
end process;

process
  begin 
    reset <= '1';
    acis_reset <= '1';
    acis_keylock <= '0';
    fault_no_clock <= '1';
    crc_en <= '0';
    crc32_en <= '0';
    crc8bit_in <= x"00";
    crc32bit_in <= x"00000000";
    pzed_spi_we <= '0';
    fiber_trig_in <= '0';
    wait for 300 ns;
    acis_keylock <= '0';
    reset <= '0';
    wait for 1 us;
    
    --wait for 1 us;
    --fault_no_clock <= '0';
    --wait for 1 us;
    --fault_no_clock <= '1';
    --wait for 1 us;
--    wait for 1.1 ms;
--    acis_reset <= '0';
--    wait for 500 us;
--    acis_reset <= '1';
--    wait for 100 us;
--    acis_reset <= '0';
--    wait for 100 us;
--    acis_reset <= '1';
--    wait for 1.1 ms;
--    acis_reset <= '0';
--    wait for 2 ms;
    
    
    
    
    wait for 200 ns;
    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 30 us;    
    
    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 30 us;    
        
    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 30 us;        
    
    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 30 us;        
       
    
    
    wait for 1000 us;
    
    wait for 3500 us;
    acis_keylock <= '0';
    wait for 100 us;
    acis_keylock <= '1';
    wait for 4000 us;
    
    acis_keylock <= '0';
    wait for 100 us;
    acis_keylock <= '1';
    wait for 4000 us;
    
    
    
    
--    wait for 2.5 ns;
    
--    crc_en <= '1';
--    crc8bit_in <= x"FF";
--    wait for 5 ns;
--    crc8bit_in <= x"FF";
--    wait for 5 ns;
--    crc8bit_in <= x"FF";
--    wait for 5 ns;
--    crc8bit_in <= x"FF";
--    wait for 5 ns;
--    crc_en <= '0';
--    wait for 100 ns;
    
--    wait for 2.5 ns;
--    crc32_en <= '1';
--    crc32bit_in <= 32d"10292021";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"13300";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;    
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"9";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;   
   
--    crc32_en <= '1';
--    crc32bit_in <= 32d"13000";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"400";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    wait for 10 us;
        
--    crc32_en <= '1';
--    crc32bit_in <= 32d"13700";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"3";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;   
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"13400";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"400";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"14100";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"2";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;      
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"13800";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"400";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"14500";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"11";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;          
  
--     crc32_en <= '1';
--    crc32bit_in <= 32d"14200";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"400";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"2100";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;        
    
--   crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;      
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;          
  
--     crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;       
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;      
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;          
  
--     crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;      
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;      
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;          
  
--     crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;     
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;  
    
--    crc32_en <= '1';
--    crc32bit_in <= 32d"";
--    wait for 5 ns;
--    crc32_en <= '0';
--    wait for 100 ns;      
    
    
    --write a soft trig spi transfer
--    pzed_spi_we <= '1';
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    wait for 200 us;
--    pzed_spi_we <= '1';
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    wait for 200 us;   
    
    wait for 1 us;

--    fiber_trig_in <= '1';
--    wait for 1 us;
--    fiber_trig_in <= '0';
--    wait for 119 us;
    
--    fiber_trig_in <= '1';
--    wait for 1 us;
--    fiber_trig_in <= '0';
--    wait for 80 us;    
    
--    fiber_trig_in <= '1';
--    wait for 1 us;
--    fiber_trig_in <= '0';
--    wait for 80 us;    
    
--    fiber_trig_in <= '1';
--    wait for 1 us;
--    fiber_trig_in <= '0';
--    wait for 80 us;    

    --write a eeprom readall
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000052";
--    pzed_spi_wrdata <= x"00000001";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 10 us;

--   --write a eeprom RSDR
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000051";
--    pzed_spi_wrdata <= x"05123400";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 10 us;
    
--   --write a eeprom trigger
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000050";
--    pzed_spi_wrdata <= x"00000001";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 20 us;   
    
  
  
    
--   --write a eeprom WRSR
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000051";
--    pzed_spi_wrdata <= x"01123400";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 10 us;
    
--   --write a eeprom trigger
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000050";
--    pzed_spi_wrdata <= x"00000001";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 20 us;   
    
    
    
--   --write a eeprom WREN
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000051";
--    pzed_spi_wrdata <= x"06123400";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 10 us;
    
--   --write a eeprom trigger
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000050";
--    pzed_spi_wrdata <= x"00000001";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 20 us;   
       
    
--  --write a eeprom WRDI
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000051";
--    pzed_spi_wrdata <= x"04123400";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 10 us;
    
--   --write a eeprom trigger
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000050";
--    pzed_spi_wrdata <= x"00000001";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 20 us;   
        
    
  
  
--  --write a eeprom READ
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000051";
--    pzed_spi_wrdata <= x"03123400";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 10 us;
    
--   --write a eeprom trigger
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000050";
--    pzed_spi_wrdata <= x"00000001";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 20 us;   
        
    
    
--  --write a eeprom WRITE
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000051";
--    pzed_spi_wrdata <= x"02123400";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 10 us;
    
--   --write a eeprom trigger
--    pzed_spi_we <= '1';
--    pzed_spi_addr <= x"00000050";
--    pzed_spi_wrdata <= x"00000001";
--    wait for 20 ns;
--    pzed_spi_we <= '0';
--    pzed_spi_addr <= x"00000000";
--    pzed_spi_wrdata <= x"00000000";   
--    wait for 20 us;   
        
    
    
    
    
    --pzed_spi_we <= '1';
    --wait for 20 ns;
    --pzed_spi_we <= '0';
    --wait for 200 us;   



    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 200 us;    
    
    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 300 us;        
    
    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 300 us;             
      
    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 300 us;       
      
    fiber_trig_in <= '1';
    wait for 1 us;
    fiber_trig_in <= '0';
    wait for 300 us;           
    
    wait for 10000 us;     
    
    
end process;


end behv;