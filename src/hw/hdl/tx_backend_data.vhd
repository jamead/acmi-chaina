library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.acmi_package.ALL;


library UNISIM;
use UNISIM.VComponents.all;

entity tx_backend_data is
  generic (
    FPGA_VERSION : integer
  );
  port (
   clk                  : in std_logic;
   reset                : in std_logic;
   adc_data             : in std_logic_vector(15 downto 0);
   adc_data_dly         : in std_logic_vector(15 downto 0);
   trig                 : in std_logic;
   startup_cnt          : in std_logic_vector(31 downto 0);
   acis_readbacks       : in std_logic_vector(7 downto 0);
   beam_cycle_window    : in std_logic;
   pulse_stats          : in pulse_stats_array;
   eeprom_params        : in eeprom_parameters_type;
   faults_rdbk          : in std_logic_vector(15 downto 0);
   faults_lat           : in std_logic_vector(15 downto 0);
   timestamp            : in std_logic_vector(31 downto 0);
   accum                : in std_logic_vector(31 downto 0);
   charge_oow           : out std_logic_vector(31 downto 0);
   pzed_sel             : out std_logic;
   tx_data              : out std_logic_vector(31 downto 0);
   tx_data_enb          : out std_logic            
  );    
end tx_backend_data;


architecture behv of tx_backend_data is


component adc_fifo IS
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END component;


  type     state_type is (IDLE, TX_RESULTS, TX_SETTINGS, TX_BEAM_OOW_DATA, TX_ADCDATA); 
  signal   state            : state_type  := idle;
  
  --signal eeprom_data    : eeprom_data_type;

  signal words_written           : INTEGER RANGE 0 to 128;
  signal adcfifo_rden            : std_logic;
  signal adcfifo_empty           : std_logic;
  signal adcfifo_dout            : std_logic_vector(15 downto 0);
  signal words_read              : std_logic_vector(15 downto 0);
  signal adcfifo_full            : std_logic;
  signal prev_beam_cycle_window  : std_logic;
  signal cycle_counter           : std_logic_vector(15 downto 0);
  signal beamoow_fifodout        : std_logic_vector(15 downto 0);
  signal beamoow_fiforden        : std_logic;
  signal beamoow_found           : std_logic;
  signal beamoow_fiforst         : std_logic;
  signal beamoow_stats           : pulse_stats_type;
  signal faults_rdbk_tp          : std_logic_vector(31 downto 0);

  


 
 
  --debug signals (connect to ila)
  attribute mark_debug                 : string;
  attribute mark_debug of tx_data_enb: signal is "true";
  attribute mark_debug of tx_data: signal is "true";
  --attribute mark_debug of words_written: signal is "true";
  --attribute mark_debug of words_read: signal is "true";
  --attribute mark_debug of adcfifo_rden: signal is "true";
  --attribute mark_debug of state: signal is "true";
  --attribute mark_debug of startup_cnt: signal is "true";

  
begin  

charge_oow <= beamoow_stats.integral;


-- adc data fifo
adc_buf: adc_fifo
  port map (
    clk => clk, 
    srst => trig, 
    din => adc_data, 
    wr_en => beam_cycle_window, 
    rd_en => adcfifo_rden, 
    dout => adcfifo_dout, 
    full => adcfifo_full, 
    empty => adcfifo_empty 
  );


--store data and parameters when beam_oow is detected
beam_oow: entity work.beamoow_fifodata
  port map (
    clk => clk,
    reset => beamoow_fiforst,
    trig => trig,
    beam_cycle_window => beam_cycle_window, 
    adc_data_dly => adc_data_dly,
    pulse_stats => pulse_stats,
    beamoow_fiforden => beamoow_fiforden,
    beamoow_fifodout => beamoow_fifodout,
    beamoow_found => beamoow_found,
    beamoow_stats => beamoow_stats
);

    
tp_fault_check: entity work.faults_tp
  port map (
    clk => clk,
    reset => reset,
    beam_cycle_window => beam_cycle_window,
    pulse_stats => pulse_stats,
    params => eeprom_params,
    faults_rdbk_tp => faults_rdbk_tp
 );    
    
    


process (clk)
  begin  
    if (rising_edge(clk)) then
      case state is
        when IDLE =>   
          tx_data <= 32d"0";
          tx_data_enb <= '0';
          adcfifo_rden <= '0';
          words_written <= 0;
          words_read <= 16d"0";
          beamoow_fiforden <= '0';
          beamoow_fiforst <= '0';
          prev_beam_cycle_window <= beam_cycle_window;
          if (beam_cycle_window = '0' and prev_beam_cycle_window = '1') then
            state <= tx_results;
          end if;


         when TX_RESULTS =>  
           words_written <= words_written + 1;
           tx_data_enb <= '1';
           case words_written is
             --header
             when 0   =>  tx_data   <= x"0000beef";
             when 1   =>  tx_data   <= std_logic_vector(to_unsigned(FPGA_VERSION,32)); 
             -- beam pulse stats
             when 2   =>  tx_data   <= std_logic_vector(resize(signed(pulse_stats(0).baseline),32));
             when 3   =>  tx_data   <= std_logic_vector(resize(signed(pulse_stats(0).peak),32));
             when 4   =>  tx_data   <= pulse_stats(0).integral;
             when 5   =>  tx_data   <= 16d"0" & pulse_stats(0).fwhm;  
             when 6   =>  tx_data   <= pulse_stats(0).peak_index;                           
             -- TP1 stats
             when 7   =>  tx_data   <= std_logic_vector(resize(signed(pulse_stats(1).baseline),32));
             when 8   =>  tx_data   <= std_logic_vector(resize(signed(pulse_stats(1).peak),32));
             when 9   =>  tx_data   <= pulse_stats(1).integral;
             when 10  =>  tx_data   <= 16d"0" & pulse_stats(1).fwhm;  
             when 11  =>  tx_data   <= pulse_stats(1).peak_index;                              
             -- TP2 stats
             when 12  =>  tx_data   <= std_logic_vector(resize(signed(pulse_stats(2).baseline),32));
             when 13  =>  tx_data   <= std_logic_vector(resize(signed(pulse_stats(2).peak),32));
             when 14  =>  tx_data   <= pulse_stats(2).integral;
             when 15  =>  tx_data   <= 16d"0" & pulse_stats(2).fwhm;  
             when 16  =>  tx_data   <= pulse_stats(2).peak_index;                                              
             -- TP3 stats
             when 17  =>  tx_data   <= std_logic_vector(resize(signed(pulse_stats(3).baseline),32));
             when 18  =>  tx_data   <= std_logic_vector(resize(signed(pulse_stats(3).peak),32));
             when 19  =>  tx_data   <= pulse_stats(3).integral;
             when 20  =>  tx_data   <= 16d"0" & pulse_stats(3).fwhm;  
             when 21  =>  tx_data   <= pulse_stats(3).peak_index;                                                             
           -- Beam out of Window stats
             when 22  =>  tx_data   <= std_logic_vector(resize(signed(beamoow_stats.baseline),32));
             when 23  =>  tx_data   <= std_logic_vector(resize(signed(beamoow_stats.peak),32));
             when 24  =>  tx_data   <= beamoow_stats.integral;
             when 25  =>  tx_data   <= 16d"0" & beamoow_stats.fwhm;  
             when 26  =>  tx_data   <= beamoow_stats.peak_index;                           
             -- faults
             when 27  =>  tx_data   <= 16d"0" & faults_rdbk;
             when 28  =>  tx_data   <= 16d"0" & faults_lat;               
             --timestamp
             when 29  =>  tx_data   <= timestamp;
             --accumulator
             when 30  =>  tx_data   <= accum;
             -- acis readbacks
             when 31  =>  tx_data   <= 24d"0" & acis_readbacks;
             --CRC calculated
             when 32  =>  tx_data   <= eeprom_params.crc32_calc;
             --tp faults readback
             when 33  =>  tx_data   <= faults_rdbk_tp;
             -- counter since power up
             when 34  =>  tx_data   <= startup_cnt;
             -- beamaccum limit
             when 35  =>  tx_data   <= 32d"0"; --eeprom_params.beamaccum_limit_calc;           
             --reserved placeholder
             when 36 to 62 => tx_data <= 32d"0";
             when 63 =>   tx_data    <= x"deadbeef";
                                      words_written <= 0;
                                      state <= tx_settings;
             when others => null;
           end case;
                                     
                                      
         when TX_SETTINGS => 
           words_written <= words_written + 1;
           case words_written is
             when 0   =>  tx_data   <= eeprom_params.header;           
             when 1   =>  tx_data   <= eeprom_params.tp1_pulse_delay; 
             when 2   =>  tx_data   <= eeprom_params.tp1_pulse_width;     
             when 3   =>  tx_data   <= eeprom_params.tp1_adc_delay;     
             when 4   =>  tx_data   <= eeprom_params.tp2_pulse_delay; 
             when 5   =>  tx_data   <= eeprom_params.tp2_pulse_width;     
             when 6  =>  tx_data   <= eeprom_params.tp2_adc_delay;                 
             when 7  =>  tx_data   <= eeprom_params.tp3_pulse_delay; 
             when 8  =>  tx_data   <= eeprom_params.tp3_pulse_width;    
             when 9  =>  tx_data   <= eeprom_params.tp3_adc_delay;                  
             when 10  =>  tx_data   <= eeprom_params.beam_adc_delay; 
             when 11  =>  tx_data   <= std_logic_vector(resize(signed(eeprom_params.beam_oow_threshold),32));  
             when 12  =>  tx_data   <= eeprom_params.tp1_int_low_limit; 
             when 13  =>  tx_data   <= eeprom_params.tp1_int_high_limit;           
             when 14  =>  tx_data   <= eeprom_params.tp2_int_low_limit;
             when 15  =>  tx_data   <= eeprom_params.tp2_int_high_limit;      
             when 16  =>  tx_data   <= eeprom_params.tp3_int_low_limit;
             when 17  =>  tx_data   <= eeprom_params.tp3_int_high_limit;                                  
             when 18  =>  tx_data   <= eeprom_params.tp1_peak_low_limit;
             when 19  =>  tx_data   <= eeprom_params.tp1_peak_high_limit;
             when 20  =>  tx_data   <= eeprom_params.tp2_peak_low_limit;
             when 21  =>  tx_data   <= eeprom_params.tp2_peak_high_limit;         
             when 22  =>  tx_data   <= eeprom_params.tp3_peak_low_limit;
             when 23  =>  tx_data   <= eeprom_params.tp3_peak_high_limit;                                 
             when 24  =>  tx_data   <= eeprom_params.tp1_fwhm_low_limit;
             when 25  =>  tx_data   <= eeprom_params.tp1_fwhm_high_limit;         
             when 26  =>  tx_data   <= eeprom_params.tp2_fwhm_low_limit;
             when 27  =>  tx_data   <= eeprom_params.tp2_fwhm_high_limit;        
             when 28  =>  tx_data   <= eeprom_params.tp3_fwhm_low_limit;
             when 29  =>  tx_data   <= eeprom_params.tp3_fwhm_high_limit;      
             when 30  =>  tx_data   <= eeprom_params.tp1_base_low_limit;                 
             when 31  =>  tx_data   <= eeprom_params.tp1_base_high_limit;       
             when 32  =>  tx_data   <= eeprom_params.tp2_base_low_limit;      
             when 33  =>  tx_data   <= eeprom_params.tp2_base_high_limit;     
             when 34  =>  tx_data   <= eeprom_params.tp3_base_low_limit;
             when 35  =>  tx_data   <= eeprom_params.tp3_base_high_limit;
             when 36  =>  tx_data   <= eeprom_params.tp1_pos_level;
             when 37  =>  tx_data   <= eeprom_params.tp2_pos_level;
             when 38  =>  tx_data   <= eeprom_params.tp3_pos_level;
             when 39  =>  tx_data   <= eeprom_params.tp1_neg_level;
             when 40  =>  tx_data   <= eeprom_params.tp2_neg_level;  
             when 41  =>  tx_data   <= eeprom_params.tp3_neg_level;                              
             when 42  =>  tx_data   <= eeprom_params.beamaccum_limit_hr;
             when 43  =>  tx_data   <= eeprom_params.beamhigh_limit;
             when 44  =>  tx_data   <= eeprom_params.baseline_low_limit;
             when 45  =>  tx_data   <= eeprom_params.baseline_high_limit;
             when 46  =>  tx_data   <= eeprom_params.charge_calibration;
             when 47  =>  tx_data   <= eeprom_params.accum_q_min;
             when 48  =>  tx_data   <= eeprom_params.accum_length;                      
             when 49  =>  tx_data   <= eeprom_params.crc32_eeprom;  
             when 50 to 61 =>  tx_data   <= 32d"0";          
             when 62 =>   tx_data <= 32d"0";
                          beamoow_fiforden <= '1';
             when 63 =>   tx_data <= 32d"0";
                          words_written <= 0;
                          --beamoow_fiforden <= '1';
                          state <= tx_beam_oow_data;
             when others => null;
           end case;
                  

 
         when TX_BEAM_OOW_DATA =>
           if (beamoow_found = '1') then      
              tx_data <= std_logic_vector(resize(signed(beamoow_fifodout),32)); 
           else
              tx_data <= 32d"0"; 
           end if;
           words_read <= words_read + 1;  
           if (words_read = 16d"126") then
             adcfifo_rden <= '1'; 
           end if;            
           if (words_read = 16d"127") then
             beamoow_fiforden <= '0';
             beamoow_fiforst <= '1';
             state <= tx_adcdata;
             words_read <= 16d"0";
           end if;              
    
    
         when TX_ADCDATA =>
           beamoow_fiforst <= '0';
           pzed_sel <= '0';
           tx_data <= std_logic_vector(resize(signed(adcfifo_dout),32));
           words_read <= words_read + 1;
           if (words_read = 16d"16000") then
             state <= idle;
           end if;
                   
       end case;
     end if; 
  end process;


  
end behv;
