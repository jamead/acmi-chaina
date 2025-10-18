library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

library work;
use work.acmi_package.ALL;


entity eeprom_interface is
  generic (
    SIM_MODE            : integer := 0
  );
  port (
   clk              : in std_logic;                  
   reset  	        : in std_logic; 
   cntrl_params     : in cntrl_parameters_type;
   eeprom_params    : out eeprom_parameters_type; 
   acis_keylock     : in std_logic;          
   sclk             : out std_logic;                   
   din 	            : out std_logic;
   dout             : in std_logic;
   csn              : out std_logic;
   holdn            : out std_logic;
   eeprom_rdy       : out std_logic                
  );    
end eeprom_interface;

architecture behv of eeprom_interface is

  signal eeprom_data    : eeprom_data_type;
  
  type     state_type is (IDLE, READ_EEPROM, WAIT_EEPROM); 
  signal   state            : state_type  := idle;

 
  signal rddata             : std_logic_vector(7 downto 0);
  signal xfer_done          : std_logic;
  signal prev_xfer_done     : std_logic;
  signal bytes_read         : INTEGER RANGE 0 to 255;
  
  signal trig               : std_logic;
  signal command            : std_logic_vector(31 downto 0) := 32d"0";
  signal addr               : std_logic_vector(31 downto 0) := 32d"0";
  signal reset_prev         : std_logic := '0';
  signal crc_en             : std_logic;
  signal crc_rst            : std_logic;
  signal crc_out            : std_logic_vector(31 downto 0);
  signal read_eeprom_done   : std_logic;
  signal accum_limit        : std_logic_vector(31 downto 0);
  signal accum_limit_t      : std_logic_vector(63 downto 0);
  signal accum_limit_f      : std_logic_vector(95 downto 0);
  signal accum_len          : std_logic_vector(31 downto 0);
  signal accum_limit_hr     : std_logic_vector(31 downto 0);
  signal acis_keylock_prev  : std_logic := '1';
  signal crc_result         : std_logic_vector(31 downto 0);

  
  
  
  attribute mark_debug                  : string;
  --attribute mark_debug of eeprom_data : signal is "true";
  attribute mark_debug of eeprom_params: signal is "true";
--  attribute mark_debug of trig : signal is "true";  
--  attribute mark_debug of bytes_read : signal is "true"; 
--  attribute mark_debug of state : signal is "true";
--  attribute mark_debug of command : signal is "true";
--  attribute mark_debug of xfer_done : signal is "true"; 
--  attribute mark_debug of crc_en : signal is "true";
--  attribute mark_debug of crc_out: signal is "true";
--  attribute mark_debug of crc_result: signal is "true";
--  attribute mark_debug of crc_rst: signal is "true";
--  attribute mark_debug of read_eeprom_done : signal is "true";
--  attribute mark_debug of accum_limit_hr: signal is "true";
--  attribute mark_debug of accum_len: signal is "true";
--  attribute mark_debug of accum_limit: signal is "true";
--  attribute mark_debug of acis_keylock: signal is "true";
--  attribute mark_debug of acis_keylock_prev: signal is "true";
--  attribute mark_debug of reset_prev : signal is "true";
--  attribute mark_debug of reset: signal is "true";
 
  
  
begin  

eeprom_rdy <= read_eeprom_done; 


eeprom_sim: if (SIM_MODE = 1) generate eeprom_sim_settings:
  eeprom_params.header               <= x"0000beef";
  eeprom_params.tp1_pulse_delay      <= 32d"4000";
  eeprom_params.tp1_pulse_width      <= 32d"8";
  eeprom_params.tp1_adc_delay        <= 32d"4073";
  eeprom_params.tp2_pulse_delay      <= 32d"6000";
  eeprom_params.tp2_pulse_width      <= 32d"3";
  eeprom_params.tp2_adc_delay        <= 32d"6073";
  eeprom_params.tp3_pulse_delay      <= 32d"8000";
  eeprom_params.tp3_pulse_width      <= 32d"2";   
  eeprom_params.tp3_adc_delay        <= 32d"8073";      
  eeprom_params.beam_adc_delay       <= 32d"215";
  eeprom_params.beam_oow_threshold   <= std_logic_vector(to_signed(150,16));
  eeprom_params.tp1_int_low_limit    <= 32d"21000";
  eeprom_params.tp1_int_high_limit   <= 32d"22000";
  eeprom_params.tp2_int_low_limit    <= std_logic_vector(to_signed(-21300,32));
  eeprom_params.tp2_int_high_limit   <= std_logic_vector(to_signed(-22300,32));
  eeprom_params.tp3_int_low_limit    <= std_logic_vector(to_signed(-4500,32));
  eeprom_params.tp3_int_high_limit   <= std_logic_vector(to_signed(-5500,32)); 
  eeprom_params.tp1_peak_low_limit   <= 32d"3000";
  eeprom_params.tp1_peak_high_limit  <= 32d"3500";
  eeprom_params.tp2_peak_low_limit   <= std_logic_vector(to_signed(-3500,32));
  eeprom_params.tp2_peak_high_limit  <= std_logic_vector(to_signed(-4500,32));
  eeprom_params.tp3_peak_low_limit   <= std_logic_vector(to_signed(-400,32));
  eeprom_params.tp3_peak_high_limit  <= std_logic_vector(to_signed(-700,32));
  eeprom_params.tp1_fwhm_low_limit   <= 32d"4";
  eeprom_params.tp1_fwhm_high_limit  <= 32d"8";
  eeprom_params.tp2_fwhm_low_limit   <= 32d"4";
  eeprom_params.tp2_fwhm_high_limit  <= 32d"8";
  eeprom_params.tp3_fwhm_low_limit   <= 32d"4"; 
  eeprom_params.tp3_fwhm_high_limit  <= 32d"8";
  eeprom_params.tp1_base_low_limit   <= std_logic_vector(to_signed(-300,32));
  eeprom_params.tp1_base_high_limit  <= 32d"300";
  eeprom_params.tp2_base_low_limit   <= std_logic_vector(to_signed(-300,32));
  eeprom_params.tp2_base_high_limit  <= 32d"300";
  eeprom_params.tp3_base_low_limit   <= std_logic_vector(to_signed(-300,32));
  eeprom_params.tp3_base_high_limit  <= 32d"300";
  eeprom_params.tp1_pos_level        <= 32d"10";
  eeprom_params.tp2_pos_level        <= 32d"0";
  eeprom_params.tp3_pos_level        <= 32d"0"; 
  eeprom_params.tp1_neg_level        <= 32d"0";
  eeprom_params.tp2_neg_level        <= 32d"11";
  eeprom_params.tp3_neg_level        <= 32d"12";
  eeprom_params.beamaccum_limit_hr   <= 32d"100000";
  eeprom_params.beamhigh_limit       <= std_logic_vector(to_signed(250000,32));
  eeprom_params.baseline_low_limit   <= std_logic_vector(to_signed(-300,32));
  eeprom_params.baseline_high_limit  <= 32d"300";
  eeprom_params.charge_calibration   <= 32d"14000";
  eeprom_params.accum_q_min          <= 32d"0";
  --eeprom_params.startup_delay        <= 32d"1800";
  eeprom_params.accum_length         <= 32d"10"; 
  eeprom_params.crc32_eeprom         <= x"01234567";
end generate;



eeprom_synth: if (SIM_MODE = 0) generate eeprom_synth_settings:
process (clk)
begin 
  if (rising_edge(clk)) then
  eeprom_params.header               <= eeprom_data(0) & eeprom_data(1) & eeprom_data(2) & eeprom_data(3);
  eeprom_params.tp1_pulse_delay      <= eeprom_data(4) & eeprom_data(5) & eeprom_data(6) & eeprom_data(7);
  eeprom_params.tp1_pulse_width      <= eeprom_data(8) & eeprom_data(9) & eeprom_data(10) & eeprom_data(11); 
  eeprom_params.tp1_adc_delay        <= eeprom_data(12) & eeprom_data(13) & eeprom_data(14) & eeprom_data(15);  
  eeprom_params.tp2_pulse_delay      <= eeprom_data(16) & eeprom_data(17) & eeprom_data(18) & eeprom_data(19);
  eeprom_params.tp2_pulse_width      <= eeprom_data(20) & eeprom_data(21) & eeprom_data(22) & eeprom_data(23);
  eeprom_params.tp2_adc_delay        <= eeprom_data(24) & eeprom_data(25) & eeprom_data(26) & eeprom_data(27);   
  eeprom_params.tp3_pulse_delay      <= eeprom_data(28) & eeprom_data(29) & eeprom_data(30) & eeprom_data(31);
  eeprom_params.tp3_pulse_width      <= eeprom_data(32) & eeprom_data(33) & eeprom_data(34) & eeprom_data(35);
  eeprom_params.tp3_adc_delay        <= eeprom_data(36) & eeprom_data(37) & eeprom_data(38) & eeprom_data(39);  
  eeprom_params.beam_adc_delay       <= eeprom_data(40) & eeprom_data(41) & eeprom_data(42) & eeprom_data(43);
  eeprom_params.beam_oow_threshold   <=                                     eeprom_data(46) & eeprom_data(47);
  eeprom_params.tp1_int_low_limit    <= eeprom_data(48) & eeprom_data(49) & eeprom_data(50) & eeprom_data(51);
  eeprom_params.tp1_int_high_limit   <= eeprom_data(52) & eeprom_data(53) & eeprom_data(54) & eeprom_data(55);
  eeprom_params.tp2_int_low_limit    <= eeprom_data(56) & eeprom_data(57) & eeprom_data(58) & eeprom_data(59);
  eeprom_params.tp2_int_high_limit   <= eeprom_data(60) & eeprom_data(61) & eeprom_data(62) & eeprom_data(63);
  eeprom_params.tp3_int_low_limit    <= eeprom_data(64) & eeprom_data(65) & eeprom_data(66) & eeprom_data(67);
  eeprom_params.tp3_int_high_limit   <= eeprom_data(68) & eeprom_data(69) & eeprom_data(70) & eeprom_data(71);
  eeprom_params.tp1_peak_low_limit   <= eeprom_data(72) & eeprom_data(73) & eeprom_data(74) & eeprom_data(75);
  eeprom_params.tp1_peak_high_limit  <= eeprom_data(76) & eeprom_data(77) & eeprom_data(78) & eeprom_data(79);
  eeprom_params.tp2_peak_low_limit   <= eeprom_data(80) & eeprom_data(81) & eeprom_data(82) & eeprom_data(83);
  eeprom_params.tp2_peak_high_limit  <= eeprom_data(84) & eeprom_data(85) & eeprom_data(86) & eeprom_data(87);
  eeprom_params.tp3_peak_low_limit   <= eeprom_data(88) & eeprom_data(89) & eeprom_data(90) & eeprom_data(91);
  eeprom_params.tp3_peak_high_limit  <= eeprom_data(92) & eeprom_data(93) & eeprom_data(94) & eeprom_data(95);
  eeprom_params.tp1_fwhm_low_limit   <= eeprom_data(96) & eeprom_data(97) & eeprom_data(98) & eeprom_data(99);
  eeprom_params.tp1_fwhm_high_limit  <= eeprom_data(100) & eeprom_data(101) & eeprom_data(102) & eeprom_data(103);
  eeprom_params.tp2_fwhm_low_limit   <= eeprom_data(104) & eeprom_data(105) & eeprom_data(106) & eeprom_data(107);
  eeprom_params.tp2_fwhm_high_limit  <= eeprom_data(108) & eeprom_data(109) & eeprom_data(110) & eeprom_data(111);
  eeprom_params.tp3_fwhm_low_limit   <= eeprom_data(112) & eeprom_data(113) & eeprom_data(114) & eeprom_data(115);
  eeprom_params.tp3_fwhm_high_limit  <= eeprom_data(116) & eeprom_data(117) & eeprom_data(118) & eeprom_data(119);
  eeprom_params.tp1_base_low_limit   <= eeprom_data(120) & eeprom_data(121) & eeprom_data(122) & eeprom_data(123);
  eeprom_params.tp1_base_high_limit  <= eeprom_data(124) & eeprom_data(125) & eeprom_data(126) & eeprom_data(127);
  eeprom_params.tp2_base_low_limit   <= eeprom_data(128) & eeprom_data(129) & eeprom_data(130) & eeprom_data(131);
  eeprom_params.tp2_base_high_limit  <= eeprom_data(132) & eeprom_data(133) & eeprom_data(134) & eeprom_data(135);
  eeprom_params.tp3_base_low_limit   <= eeprom_data(136) & eeprom_data(137) & eeprom_data(138) & eeprom_data(139);
  eeprom_params.tp3_base_high_limit  <= eeprom_data(140) & eeprom_data(141) & eeprom_data(142) & eeprom_data(143);
  eeprom_params.tp1_pos_level        <= eeprom_data(144) & eeprom_data(145) & eeprom_data(146) & eeprom_data(147);
  eeprom_params.tp2_pos_level        <= eeprom_data(148) & eeprom_data(149) & eeprom_data(150) & eeprom_data(151);
  eeprom_params.tp3_pos_level        <= eeprom_data(152) & eeprom_data(153) & eeprom_data(154) & eeprom_data(155); 
  eeprom_params.tp1_neg_level        <= eeprom_data(156) & eeprom_data(157) & eeprom_data(158) & eeprom_data(159);
  eeprom_params.tp2_neg_level        <= eeprom_data(160) & eeprom_data(161) & eeprom_data(162) & eeprom_data(163);
  eeprom_params.tp3_neg_level        <= eeprom_data(164) & eeprom_data(165) & eeprom_data(166) & eeprom_data(167); 
  eeprom_params.beamaccum_limit_hr   <= eeprom_data(168) & eeprom_data(169) & eeprom_data(170) & eeprom_data(171);
  eeprom_params.beamhigh_limit       <= eeprom_data(172) & eeprom_data(173) & eeprom_data(174) & eeprom_data(175);
  eeprom_params.baseline_low_limit   <= eeprom_data(176) & eeprom_data(177) & eeprom_data(178) & eeprom_data(179);
  eeprom_params.baseline_high_limit  <= eeprom_data(180) & eeprom_data(181) & eeprom_data(182) & eeprom_data(183);
  eeprom_params.charge_calibration   <= eeprom_data(184) & eeprom_data(185) & eeprom_data(186) & eeprom_data(187);
  eeprom_params.accum_q_min          <= eeprom_data(188) & eeprom_data(189) & eeprom_data(190) & eeprom_data(191);
  eeprom_params.accum_length         <= eeprom_data(192) & eeprom_data(193) & eeprom_data(194) & eeprom_data(195);    
  eeprom_params.crc32_eeprom         <= eeprom_data(196) & eeprom_data(197) & eeprom_data(198) & eeprom_data(199);
 end if;
end process;
end generate;  
 
 
 
--calculate the accumulation limit (based on the limit for 1hr * accum_length 
-- accum limit = 1hr_Qlimit * Accum_length / 7200   (1/7200*2^32 = 596523) 

--eeprom_params.beamaccum_limit_calc <= 32d"15000000";
process (clk)
begin
  if rising_edge(clk) then
     accum_limit_hr <= eeprom_params.beamaccum_limit_hr;
     accum_len <= eeprom_params.accum_length;
     accum_limit_t <= accum_limit_hr * accum_len;
     accum_limit_f <= accum_limit_t * 32d"596523";
     --eeprom_params.beamaccum_limit_calc <= accum_limit_f(63 downto 32);
  end if;
end process;
  

   

-- non-volatile memory for settings
eeprom: entity work.eeprom_spi
  port map(
    clk => clk,                   
    reset => reset,
    trig => trig,
    command => command,                            
    sclk => sclk,                    
    din => din, 
    dout => dout,
    csn => csn, 
    holdn => holdn,
    rddata => rddata,
    xfer_done => xfer_done                 
);    




process (clk)
  begin  
    if (rising_edge(clk)) then
        case state is
          when IDLE =>   
            crc_en <= '0';
            read_eeprom_done <= '0';
            bytes_read <= 0;
            trig <= '0';
            reset_prev <= reset;
            acis_keylock_prev <= acis_keylock;
            -- single transaction requested from picoZed (for writing eeprom)
            if (cntrl_params.eeprom_trig = '1') then
              command <= cntrl_params.eeprom_wrdata;
              trig <= cntrl_params.eeprom_trig;
          
            --read all eeprom settings on readall, powerup or keylock going to run mode
            --acis_keylock: 1=run mode, 0=edit mode
            elsif ((cntrl_params.eeprom_readall = '1') or (reset_prev = '1' and reset = '0') or 
                  (reset = '0' and reset_prev = '0' and acis_keylock = '1' and acis_keylock_prev = '0')) then
              crc_rst <= '1';
              state <= read_eeprom;
              command <= x"03000000";
              addr <= x"00000000";
              bytes_read <= 0;
            else
              state <= idle;
            end if;
              
                          
          when READ_EEPROM => 
            crc_rst <= '0';
            crc_en <= '0';
            command <= x"03000000" + addr;
            addr <= addr + x"00000100"; 
            trig <= '1';
            state <= wait_eeprom;
            
            
          when WAIT_EEPROM => 
            trig <= '0';
            prev_xfer_done <= xfer_done;
            if (prev_xfer_done = '1' and xfer_done = '0') then
              crc_en <= '1';
              eeprom_data(bytes_read) <= rddata;
              if (bytes_read >= EEPROM_LEN-4) then
                crc_en <= '0';  --don't include CRC in file for calc.
              end if;
              if (bytes_read = EEPROM_LEN) then 
                read_eeprom_done <= '1';
                state <= idle;
              else
                state <= read_eeprom; 
                bytes_read <= bytes_read + 1;
              end if;  
            end if;
             
         end case;
       end if;
  end process;


--store the vhdl calculated crc
process(clk)
begin
  if (rising_edge(clk)) then
    if (read_eeprom_done <= '1') then
      eeprom_params.crc32_calc <= crc_result; --crc_out;
    end if;
  end if;
end process;

-- checks CRC of eeprom settings in FPGA at 1Hz
crc_check_1hz: entity work.crc_compute
  port map (
    clk => clk,
    reset => reset,
    eeprom_data => eeprom_data,
    crc_calc => crc_result
);


-- can remove, now check at 1Hz.
crc32gen: entity work.crc 
  port map ( 
    data_in => rddata,
    crc_en => crc_en, 
    rst => crc_rst,
    clk => clk, 
    crc_out => crc_out 
);


end behv;
