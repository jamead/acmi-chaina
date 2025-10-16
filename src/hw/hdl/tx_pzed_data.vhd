library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.acmi_package.ALL;


library UNISIM;
use UNISIM.VComponents.all;

entity tx_pzed_data is
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
   pzed_clk             : out std_logic;
   pzed_data            : out std_logic_vector(15 downto 0);
   pzed_enb             : out std_logic;
   pzed_sel             : out std_logic            
  );    
end tx_pzed_data;


architecture behv of tx_pzed_data is


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
  attribute mark_debug of pzed_enb: signal is "true";
  attribute mark_debug of pzed_sel: signal is "true";
  attribute mark_debug of pzed_data: signal is "true";
  attribute mark_debug of words_written: signal is "true";
  attribute mark_debug of words_read: signal is "true";
  attribute mark_debug of adcfifo_rden: signal is "true";
  attribute mark_debug of state: signal is "true";
  attribute mark_debug of startup_cnt: signal is "true";

  
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
    
    

pzed_clk <= clk;

process (clk)
  begin  
    if (rising_edge(clk)) then
      case state is
        when IDLE =>   
          pzed_data <= 16d"0";
          adcfifo_rden <= '0';
          pzed_enb   <= '0';
          pzed_sel   <= '0';
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
           pzed_enb <= '1';
           pzed_sel <= '1';
           case words_written is
             when 0   =>  pzed_data   <= x"0000";
             when 1   =>  pzed_data   <= x"8000";
             when 2   =>  pzed_data   <= x"0000";
             when 3   =>  pzed_data   <= std_logic_vector(to_unsigned(FPGA_VERSION,16)); 
             -- beam pulse stats
             when 4   =>  pzed_data   <= (others => pulse_stats(0).baseline(15));
             when 5   =>  pzed_data   <= pulse_stats(0).baseline(15 downto 0);
             when 6   =>  pzed_data   <= (others => pulse_stats(0).peak(16));
             when 7   =>  pzed_data   <= pulse_stats(0).peak(15 downto 0);
             when 8   =>  pzed_data   <= pulse_stats(0).integral(31 downto 16);
             when 9   =>  pzed_data   <= pulse_stats(0).integral(15 downto 0);   
             when 10  =>  pzed_data   <= x"0000";
             when 11  =>  pzed_data   <= pulse_stats(0).fwhm(15 downto 0);               
             when 12  =>  pzed_data   <= pulse_stats(0).peak_index(31 downto 16);
             when 13  =>  pzed_data   <= pulse_stats(0).peak_index(15 downto 0);                         
             -- TP1 stats
             when 14  =>  pzed_data   <= (others => pulse_stats(1).baseline(15));
             when 15  =>  pzed_data   <= pulse_stats(1).baseline(15 downto 0);
             when 16  =>  pzed_data   <= (others => pulse_stats(1).peak(16));
             when 17  =>  pzed_data   <= pulse_stats(1).peak(15 downto 0);
             when 18  =>  pzed_data   <= pulse_stats(1).integral(31 downto 16);
             when 19  =>  pzed_data   <= pulse_stats(1).integral(15 downto 0);   
             when 20  =>  pzed_data   <= x"0000";
             when 21  =>  pzed_data   <= pulse_stats(1).fwhm(15 downto 0);               
             when 22  =>  pzed_data   <= pulse_stats(1).peak_index(31 downto 16);
             when 23  =>  pzed_data   <= pulse_stats(1).peak_index(15 downto 0);              
             -- TP2 stats
             when 24  =>  pzed_data   <= (others => pulse_stats(2).baseline(15));
             when 25  =>  pzed_data   <= pulse_stats(2).baseline(15 downto 0);
             when 26  =>  pzed_data   <= (others => pulse_stats(2).peak(16));
             when 27  =>  pzed_data   <= pulse_stats(2).peak(15 downto 0);
             when 28  =>  pzed_data   <= pulse_stats(2).integral(31 downto 16);
             when 29  =>  pzed_data   <= pulse_stats(2).integral(15 downto 0);   
             when 30  =>  pzed_data   <= x"0000";
             when 31  =>  pzed_data   <= pulse_stats(2).fwhm(15 downto 0);               
             when 32  =>  pzed_data   <= pulse_stats(2).peak_index(31 downto 16);
             when 33  =>  pzed_data   <= pulse_stats(2).peak_index(15 downto 0);                    
             -- TP3 stats
             when 34  =>  pzed_data   <= (others => pulse_stats(3).baseline(15));
             when 35  =>  pzed_data   <= pulse_stats(3).baseline(15 downto 0);
             when 36  =>  pzed_data   <= (others => pulse_stats(3).peak(16));
             when 37  =>  pzed_data   <= pulse_stats(3).peak(15 downto 0);
             when 38  =>  pzed_data   <= pulse_stats(3).integral(31 downto 16);
             when 39  =>  pzed_data   <= pulse_stats(3).integral(15 downto 0);   
             when 40  =>  pzed_data   <= x"0000";
             when 41  =>  pzed_data   <= pulse_stats(3).fwhm(15 downto 0);               
             when 42  =>  pzed_data   <= pulse_stats(3).peak_index(31 downto 16);
             when 43  =>  pzed_data   <= pulse_stats(3).peak_index(15 downto 0);                                       
           -- Beam out of Window stats
             when 44  =>  pzed_data   <= (others => beamoow_stats.baseline(15));
             when 45  =>  pzed_data   <= beamoow_stats.baseline(15 downto 0);
             when 46  =>  pzed_data   <= (others => beamoow_stats.peak(16));
             when 47  =>  pzed_data   <= beamoow_stats.peak(15 downto 0);
             when 48  =>  pzed_data   <= beamoow_stats.integral(31 downto 16);
             when 49  =>  pzed_data   <= beamoow_stats.integral(15 downto 0);   
             when 50  =>  pzed_data   <= x"0000";
             when 51  =>  pzed_data   <= beamoow_stats.fwhm(15 downto 0);               
             when 52  =>  pzed_data   <= beamoow_stats.peak_index(31 downto 16);
             when 53  =>  pzed_data   <= beamoow_stats.peak_index(15 downto 0);                 
             -- faults
             when 54  =>  pzed_data   <= x"0000";
             when 55  =>  pzed_data   <= faults_rdbk;              
             when 56  =>  pzed_data   <= x"0000";
             when 57  =>  pzed_data   <= faults_lat;
             --timestamp
             when 58  =>  pzed_data   <= timestamp(31 downto 16);
             when 59  =>  pzed_data   <= timestamp(15 downto 0);
             --accumulator
             when 60  =>  pzed_data   <= accum(31 downto 16);
             when 61  =>  pzed_data   <= accum(15 downto 0);
             -- acis readbacks
             when 62  =>  pzed_data   <= x"0000";  
             when 63  =>  pzed_data   <= x"00" & acis_readbacks;
             --CRC calculated
             when 64  =>  pzed_data   <= eeprom_params.crc32_calc(31 downto 16);
             when 65  =>  pzed_data   <= eeprom_params.crc32_calc(15 downto 0);
             --tp faults readback
             when 66  =>  pzed_data   <= faults_rdbk_tp(31 downto 16);
             when 67  =>  pzed_data   <= faults_rdbk_tp(15 downto 0); 
 
             when 68  =>  pzed_data   <= startup_cnt(31 downto 16);
             when 69  =>  pzed_data   <= startup_cnt(15 downto 0);  
                      
             --reserved placeholder
             when 70 to 125 => pzed_data <= x"0000"; --std_logic_vector(to_unsigned(words_written,16)); 
             when 126 => pzed_data    <= x"dead";
             when 127 => pzed_data    <= x"beef";
                                      words_written <= 0;
                                      state <= tx_settings;
             when others => null;
           end case;
                                     
                                      
         when TX_SETTINGS => 
           words_written <= words_written + 1;
           case words_written is
             when 0   =>  pzed_data   <= eeprom_params.header(31 downto 16);
             when 1   =>  pzed_data   <= eeprom_params.header(15 downto 0);
             when 2   =>  pzed_data   <= eeprom_params.tp1_pulse_delay(31 downto 16); 
             when 3   =>  pzed_data   <= eeprom_params.tp1_pulse_delay(15 downto 0);
             when 4   =>  pzed_data   <= eeprom_params.tp1_pulse_width(31 downto 16);
             when 5   =>  pzed_data   <= eeprom_params.tp1_pulse_width(15 downto 0);           
             when 6  =>  pzed_data   <= eeprom_params.tp1_adc_delay(31 downto 16);
             when 7  =>  pzed_data   <= eeprom_params.tp1_adc_delay(15 downto 0);                          
             when 8  =>  pzed_data   <= eeprom_params.tp2_pulse_delay(31 downto 16); 
             when 9  =>  pzed_data   <= eeprom_params.tp2_pulse_delay(15 downto 0);
             when 10  =>  pzed_data   <= eeprom_params.tp2_pulse_width(31 downto 16);
             when 11  =>  pzed_data   <= eeprom_params.tp2_pulse_width(15 downto 0);     
             when 12  =>  pzed_data   <= eeprom_params.tp2_adc_delay(31 downto 16); 
             when 13  =>  pzed_data   <= eeprom_params.tp2_adc_delay(15 downto 0);              
             when 14  =>  pzed_data   <= eeprom_params.tp3_pulse_delay(31 downto 16); 
             when 15  =>  pzed_data   <= eeprom_params.tp3_pulse_delay(15 downto 0);
             when 16  =>  pzed_data   <= eeprom_params.tp3_pulse_width(31 downto 16);
             when 17  =>  pzed_data   <= eeprom_params.tp3_pulse_width(15 downto 0);
             when 18  =>  pzed_data   <= eeprom_params.tp3_adc_delay(31 downto 16);
             when 19  =>  pzed_data   <= eeprom_params.tp3_adc_delay(15 downto 0);           
             when 20  =>  pzed_data   <= eeprom_params.beam_adc_delay(31 downto 16); 
             when 21  =>  pzed_data   <= eeprom_params.beam_adc_delay(15 downto 0);                            
             when 22  =>  pzed_data   <= (others => eeprom_params.beam_oow_threshold(15));
             when 23  =>  pzed_data   <= eeprom_params.beam_oow_threshold(15 downto 0);         
             when 24  =>  pzed_data   <= eeprom_params.tp1_int_low_limit(31 downto 16);
             when 25  =>  pzed_data   <= eeprom_params.tp1_int_low_limit(15 downto 0);    
             when 26  =>  pzed_data   <= eeprom_params.tp1_int_high_limit(31 downto 16);
             when 27  =>  pzed_data   <= eeprom_params.tp1_int_high_limit(15 downto 0);                 
             when 28  =>  pzed_data   <= eeprom_params.tp2_int_low_limit(31 downto 16);
             when 29  =>  pzed_data   <= eeprom_params.tp2_int_low_limit(15 downto 0);    
             when 30  =>  pzed_data   <= eeprom_params.tp2_int_high_limit(31 downto 16);
             when 31  =>  pzed_data   <= eeprom_params.tp2_int_high_limit(15 downto 0);                 
             when 32  =>  pzed_data   <= eeprom_params.tp3_int_low_limit(31 downto 16);
             when 33  =>  pzed_data   <= eeprom_params.tp3_int_low_limit(15 downto 0);    
             when 34  =>  pzed_data   <= eeprom_params.tp3_int_high_limit(31 downto 16);
             when 35  =>  pzed_data   <= eeprom_params.tp3_int_high_limit(15 downto 0);                                               
             when 36  =>  pzed_data   <= eeprom_params.tp1_peak_low_limit(31 downto 16);
             when 37  =>  pzed_data   <= eeprom_params.tp1_peak_low_limit(15 downto 0);    
             when 38  =>  pzed_data   <= eeprom_params.tp1_peak_high_limit(31 downto 16);
             when 39  =>  pzed_data   <= eeprom_params.tp1_peak_high_limit(15 downto 0);                 
             when 40  =>  pzed_data   <= eeprom_params.tp2_peak_low_limit(31 downto 16);
             when 41  =>  pzed_data   <= eeprom_params.tp2_peak_low_limit(15 downto 0);    
             when 42  =>  pzed_data   <= eeprom_params.tp2_peak_high_limit(31 downto 16);
             when 43  =>  pzed_data   <= eeprom_params.tp2_peak_high_limit(15 downto 0);                 
             when 44  =>  pzed_data   <= eeprom_params.tp3_peak_low_limit(31 downto 16);
             when 45  =>  pzed_data   <= eeprom_params.tp3_peak_low_limit(15 downto 0);    
             when 46  =>  pzed_data   <= eeprom_params.tp3_peak_high_limit(31 downto 16);
             when 47  =>  pzed_data   <= eeprom_params.tp3_peak_high_limit(15 downto 0);                                        
             when 48  =>  pzed_data   <= eeprom_params.tp1_peak_low_limit(31 downto 16);
             when 49  =>  pzed_data   <= eeprom_params.tp1_fwhm_low_limit(15 downto 0);    
             when 50  =>  pzed_data   <= eeprom_params.tp1_fwhm_high_limit(31 downto 16);
             when 51  =>  pzed_data   <= eeprom_params.tp1_fwhm_high_limit(15 downto 0);                 
             when 52  =>  pzed_data   <= eeprom_params.tp2_fwhm_low_limit(31 downto 16);
             when 53  =>  pzed_data   <= eeprom_params.tp2_fwhm_low_limit(15 downto 0);    
             when 54  =>  pzed_data   <= eeprom_params.tp2_fwhm_high_limit(31 downto 16);
             when 55  =>  pzed_data   <= eeprom_params.tp2_fwhm_high_limit(15 downto 0);                 
             when 56  =>  pzed_data   <= eeprom_params.tp3_fwhm_low_limit(31 downto 16);
             when 57  =>  pzed_data   <= eeprom_params.tp3_fwhm_low_limit(15 downto 0);    
             when 58  =>  pzed_data   <= eeprom_params.tp3_fwhm_high_limit(31 downto 16);
             when 59  =>  pzed_data   <= eeprom_params.tp3_fwhm_high_limit(15 downto 0);                 
             when 60  =>  pzed_data   <= eeprom_params.tp1_base_low_limit(31 downto 16);         
             when 61  =>  pzed_data   <= eeprom_params.tp1_base_low_limit(15 downto 0);    
             when 62  =>  pzed_data   <= eeprom_params.tp1_base_high_limit(31 downto 16);
             when 63  =>  pzed_data   <= eeprom_params.tp1_base_high_limit(15 downto 0);                 
             when 64  =>  pzed_data   <= eeprom_params.tp2_base_low_limit(31 downto 16);
             when 65  =>  pzed_data   <= eeprom_params.tp2_base_low_limit(15 downto 0);    
             when 66  =>  pzed_data   <= eeprom_params.tp2_base_high_limit(31 downto 16);
             when 67  =>  pzed_data   <= eeprom_params.tp2_base_high_limit(15 downto 0);                 
             when 68  =>  pzed_data   <= eeprom_params.tp3_base_low_limit(31 downto 16);
             when 69  =>  pzed_data   <= eeprom_params.tp3_base_low_limit(15 downto 0);    
             when 70  =>  pzed_data   <= eeprom_params.tp3_base_high_limit(31 downto 16);
             when 71  =>  pzed_data   <= eeprom_params.tp3_base_high_limit(15 downto 0);   
             
             when 72  =>  pzed_data   <= eeprom_params.tp1_pos_level(31 downto 16);
             when 73  =>  pzed_data   <= eeprom_params.tp1_pos_level(15 downto 0);   
             when 74  =>  pzed_data   <= eeprom_params.tp2_pos_level(31 downto 16);
             when 75  =>  pzed_data   <= eeprom_params.tp2_pos_level(15 downto 0);   
             when 76  =>  pzed_data   <= eeprom_params.tp3_pos_level(31 downto 16);
             when 77  =>  pzed_data   <= eeprom_params.tp3_pos_level(15 downto 0);              
             when 78  =>  pzed_data   <= eeprom_params.tp1_neg_level(31 downto 16);
             when 79  =>  pzed_data   <= eeprom_params.tp1_neg_level(15 downto 0);   
             when 80  =>  pzed_data   <= eeprom_params.tp2_neg_level(31 downto 16);
             when 81  =>  pzed_data   <= eeprom_params.tp2_neg_level(15 downto 0);   
             when 82  =>  pzed_data   <= eeprom_params.tp3_neg_level(31 downto 16);
             when 83  =>  pzed_data   <= eeprom_params.tp3_neg_level(15 downto 0);                                                             
             when 84  =>  pzed_data   <= eeprom_params.beamaccum_limit_hr(31 downto 16);
             when 85  =>  pzed_data   <= eeprom_params.beamaccum_limit_hr(15 downto 0);         
             when 86  =>  pzed_data   <= eeprom_params.beamhigh_limit(31 downto 16);
             when 87  =>  pzed_data   <= eeprom_params.beamhigh_limit(15 downto 0);         
             when 88  =>  pzed_data   <= eeprom_params.baseline_low_limit(31 downto 16);
             when 89  =>  pzed_data   <= eeprom_params.baseline_low_limit(15 downto 0);         
             when 90  =>  pzed_data   <= eeprom_params.baseline_high_limit(31 downto 16);
             when 91  =>  pzed_data   <= eeprom_params.baseline_high_limit(15 downto 0);  
             when 92 =>  pzed_data   <= eeprom_params.charge_calibration(31 downto 16);
             when 93 =>  pzed_data   <= eeprom_params.charge_calibration(15 downto 0); 
             when 94 =>  pzed_data   <= eeprom_params.accum_q_min(31 downto 16);
             when 95 =>  pzed_data   <= eeprom_params.accum_q_min(15 downto 0);             
             when 96 =>  pzed_data   <= eeprom_params.accum_length(31 downto 16);
             when 97 =>  pzed_data   <= eeprom_params.accum_length(15 downto 0);                                  
             when 98 =>  pzed_data   <= eeprom_params.crc32_eeprom(31 downto 16);
             when 99 =>  pzed_data   <= eeprom_params.crc32_eeprom(15 downto 0);
                  
             when 100 to 125   =>  pzed_data <= x"0000";
                         
             when 126 =>  pzed_data <= x"0000";
                          beamoow_fiforden <= '1';
             when 127 =>  pzed_data   <= x"0000";
                          words_written <= 0;
                          --beamoow_fiforden <= '1';
                          state <= tx_beam_oow_data;
             when others => null;
           end case;
                  

 
         when TX_BEAM_OOW_DATA =>
           if (beamoow_found = '1') then      
              pzed_data <= beamoow_fifodout; 
           else
              pzed_data <= x"0000";
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
           pzed_data <= adcfifo_dout;
           words_read <= words_read + 1;
           if (words_read = 16d"16000") then
             state <= idle;
           end if;
                   
       end case;
     end if; 
  end process;


  
end behv;
