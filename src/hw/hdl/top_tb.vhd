----------------------------------------------------------------------------------
-- Top Test Bench
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;


entity top_tb is
end top_tb;

architecture behv of top_tb is


component top is
generic(
    FPGA_VERSION			: integer := 2;
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
    fiber_trig_led            : out std_logic;
    fiber_trig_fp             : out std_logic; 
    fiber_trig_watchdog       : out std_logic;       
      
    -- gtp to kria
    gtp_refclk1_p             : in std_logic;
    gtp_refclk1_n             : in std_logic;
    gtp_tx0_p                 : out std_logic;
    gtp_tx0_n                 : out std_logic;
    gtp_rx0_p                 : in std_logic;
    gtp_rx0_n                 : in std_logic;

    
    --test pulse signals    
    tp_pos_pulse              : out std_logic_vector(4 downto 0);
    tp_neg_pulse              : out std_logic_vector(4 downto 0);

    
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
    
    --trigger I/O
    signal fiber_trig_led            : std_logic;
    signal fiber_trig_fp             : std_logic;
    signal fiber_trig_watchdog       : std_logic;      
    
    -- gtp to kria
    signal gtp_refclk1_p             : std_logic;
    signal gtp_refclk1_n             : std_logic;
    signal gtp_tx0_p                 : std_logic;
    signal gtp_tx0_n                 : std_logic;
    signal gtp_rx0_p                 : std_logic;
    signal gtp_rx0_n                 : std_logic;
  
    
    --test pulse signals    
    signal tp_pos_pulse              : std_logic_vector(4 downto 0);
    signal tp_neg_pulse              : std_logic_vector(4 downto 0);


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

  
 
begin
    
  
dut: top 
  generic map(
    FPGA_VERSION => 2, 
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
    
    fiber_trig_led => fiber_trig_led, 
    fiber_trig_fp => fiber_trig_fp, 
    fiber_trig_watchdog => fiber_trig_watchdog,    
     
    -- gtp to kria
    gtp_refclk1_p => gtp_refclk1_p, 
    gtp_refclk1_n => gtp_refclk1_n,
    gtp_tx0_p => gtp_tx0_p, 
    gtp_tx0_n => gtp_tx0_n,
    gtp_rx0_p => gtp_rx0_p, 
    gtp_rx0_n => gtp_rx0_n, 
 
    --test pulse signals    
    tp_pos_pulse => tp_pos_pulse, 
    tp_neg_pulse => tp_neg_pulse,
    
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





gtp_rx0_p <= gtp_tx0_p;
gtp_rx0_n <= gtp_tx0_n;







gtp_refclk1_n <= not gtp_refclk1_p;
process
  begin 
    gtp_refclk1_p <= '1';
    wait for 3.125 ns;
    gtp_refclk1_p <= '0'; 
    wait for 3.125 ns;
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
    wait for 15 us;
    reset <= '0';
    wait for 1 us;
    acis_keylock <= '1';
--    wait for 1 us;
--    acis_keylock <= '0';
--    wait for 1 us;
--    acis_keylock <= '1';
    
    wait for 10000 us;     
    
    
end process;


end behv;
