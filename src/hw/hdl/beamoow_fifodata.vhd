library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.acmi_package.ALL;


library UNISIM;
use UNISIM.VComponents.all;

entity beamoow_fifodata is
  port (
   clk                  : in std_logic;
   reset                : in std_logic;
   trig                 : in std_logic;
   beam_cycle_window    : in std_logic;
   adc_data_dly         : in std_logic_vector(15 downto 0);
   pulse_stats          : in pulse_stats_array;
   beamoow_fiforden     : in std_logic;
   beamoow_fifodout     : out std_logic_vector(15 downto 0);
   beamoow_found        : out std_logic;
   beamoow_stats        : out pulse_stats_type
          
  );    
end beamoow_fifodata;


architecture behv of beamoow_fifodata is


component beamoow_fifo IS
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

component adc_shift_ram
  port (
    d : in std_logic_vector(15 downto 0); 
    clk : in std_logic; 
    q : out std_logic_vector(15 downto 0)
  );
end component;



  type     state_type is (IDLE, WAITFORPEAK, STORE2FIFO, WAITFORTRIGGER); 
  signal   state            : state_type  := idle;

  signal words_written          : std_logic_vector(7 downto 0);
  signal beamoow_fifowren       : std_logic;
  signal beamoow_data           : std_logic_vector(15 downto 0);
  signal peak_found             : std_logic;


 
  --debug signals (connect to ila)
  attribute mark_debug                 : string;
  attribute mark_debug of state: signal is "true";
  attribute mark_debug of beamoow_data: signal is "true";
  attribute mark_debug of beamoow_stats: signal is "true";
  attribute mark_debug of beamoow_fifowren: signal is "true";

  
begin  




-- adc data fifo
beamoow_buf: beamoow_fifo
  port map (
    clk => clk, 
    srst => reset,  
    din => beamoow_data,  
    wr_en => beamoow_fifowren,  
    rd_en => beamoow_fiforden, 
    dout => beamoow_fifodout,  
    full => open, 
    empty => open 
  );


adc_dly : adc_shift_ram
  PORT MAP (
    D => std_logic_vector(adc_data_dly),
    CLK => clk,
    Q => beamoow_data
  );



process (clk)
  begin  
    if (rising_edge(clk)) then
      case state is
        when IDLE =>  
          beamoow_fifowren <= '0';
          --beamoow_data <= 16d"0";
          words_written <= 8d"0";
          peak_found <= '0';
          state <= waitforpeak;
 
 
  
        when WAITFORPEAK =>           
          if (trig = '1') then
            beamoow_stats.integral <= 32d"0"; 
            beamoow_stats.baseline <= 16d"0"; 
            beamoow_stats.peak <= 17d"0";
            beamoow_stats.peak_index <= 32d"0";
            beamoow_stats.threshold <= pulse_stats(4).threshold;
            beamoow_stats.fwhm <= 16d"0"; 
            beamoow_found <= '0';          
            peak_found <= '0';
            state <= idle;
          end if;
          if (pulse_stats(4).peak_found = '1') then
            peak_found <= '1';  
            state <= store2fifo;
          end if;
          

         when STORE2FIFO => 
           beamoow_fifowren <= '1';
           --beamoow_data <= adc_data_dly;
           if (words_written = 16d"127") then
             beamoow_fifowren <= '0'; 
             state <= waitfortrigger;
           else
             words_written <= words_written + 1;         
           end if;    
 
 
         when WAITFORTRIGGER =>
          if (trig = '1') then
            beamoow_stats.integral <= pulse_stats(4).integral;
            beamoow_stats.baseline <= pulse_stats(4).baseline;
            beamoow_stats.peak <= pulse_stats(4).peak;
            beamoow_stats.peak_index <= pulse_stats(4).peak_index;
            beamoow_stats.threshold <= pulse_stats(4).threshold;
            beamoow_stats.fwhm <= pulse_stats(4).fwhm;       
            beamoow_found <= '1'; 
            state <= idle;       
          end if;


   
       end case;
     end if; 
  end process;


  
end behv;
