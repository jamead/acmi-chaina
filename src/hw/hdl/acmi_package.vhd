
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


package acmi_package is

constant POS_PULSE      : std_logic := '0';
constant NEG_PULSE      : std_logic := '1';

type PULSE_CNFG_TYPE is array(0 to 7) of std_logic_vector(31 downto 0);


constant EEPROM_LEN   : INTEGER  := 200;
type eeprom_data_type is array(0 to EEPROM_LEN) of std_logic_vector(7 downto 0);



type cntrl_parameters_type is record
    accum_reset          : std_logic; 
    eeprom_trig          : std_logic;
    eeprom_readall       : std_logic;
    trig_out_delay       : std_logic_vector(31 downto 0);
    trig_out_enable      : std_logic;
    eeprom_wrdata        : std_logic_vector(31 downto 0);
end record cntrl_parameters_type;
 

type eeprom_parameters_type is record
    header                   : std_logic_vector(31 downto 0);
    --tp1_gate_delay           : std_logic_vector(31 downto 0);
    --tp1_gate_width           : std_logic_vector(31 downto 0);
    tp1_pulse_delay          : std_logic_vector(31 downto 0);
    tp1_pulse_width          : std_logic_vector(31 downto 0); 
    tp1_adc_delay            : std_logic_vector(31 downto 0);
    --tp1_threshold            : std_logic_vector(15 downto 0);
    --tp2_gate_delay           : std_logic_vector(31 downto 0);
    --tp2_gate_width           : std_logic_vector(31 downto 0);
    tp2_pulse_delay          : std_logic_vector(31 downto 0);
    tp2_pulse_width          : std_logic_vector(31 downto 0);
    tp2_adc_delay            : std_logic_vector(31 downto 0); 
    --tp2_threshold            : std_logic_vector(15 downto 0);    
    --tp3_gate_delay           : std_logic_vector(31 downto 0);
    --tp3_gate_width           : std_logic_vector(31 downto 0);
    tp3_pulse_delay          : std_logic_vector(31 downto 0);
    tp3_pulse_width          : std_logic_vector(31 downto 0); 
    tp3_adc_delay            : std_logic_vector(31 downto 0);
    --tp3_threshold            : std_logic_vector(15 downto 0);
    beam_adc_delay           : std_logic_vector(31 downto 0);
    --tp1_adc_delay            : std_logic_vector(31 downto 0);
    --tp2_adc_delay            : std_logic_vector(31 downto 0);
    --tp3_adc_delay            : std_logic_vector(31 downto 0);    
    --beam_threshold           : std_logic_vector(15 downto 0); 
    beam_oow_threshold       : std_logic_vector(15 downto 0);
    tp1_int_high_limit       : std_logic_vector(31 downto 0);
    tp1_int_low_limit        : std_logic_vector(31 downto 0);
    tp2_int_high_limit       : std_logic_vector(31 downto 0);
    tp2_int_low_limit        : std_logic_vector(31 downto 0); 
    tp3_int_high_limit       : std_logic_vector(31 downto 0);
    tp3_int_low_limit        : std_logic_vector(31 downto 0); 
    tp1_peak_high_limit      : std_logic_vector(31 downto 0);
    tp1_peak_low_limit       : std_logic_vector(31 downto 0);
    tp2_peak_high_limit      : std_logic_vector(31 downto 0);
    tp2_peak_low_limit       : std_logic_vector(31 downto 0); 
    tp3_peak_high_limit      : std_logic_vector(31 downto 0);
    tp3_peak_low_limit       : std_logic_vector(31 downto 0); 
    tp1_fwhm_high_limit      : std_logic_vector(31 downto 0);
    tp1_fwhm_low_limit       : std_logic_vector(31 downto 0);
    tp2_fwhm_high_limit      : std_logic_vector(31 downto 0);
    tp2_fwhm_low_limit       : std_logic_vector(31 downto 0); 
    tp3_fwhm_high_limit      : std_logic_vector(31 downto 0);
    tp3_fwhm_low_limit       : std_logic_vector(31 downto 0); 
    tp1_base_high_limit      : std_logic_vector(31 downto 0);
    tp1_base_low_limit       : std_logic_vector(31 downto 0);
    tp2_base_high_limit      : std_logic_vector(31 downto 0);
    tp2_base_low_limit       : std_logic_vector(31 downto 0); 
    tp3_base_high_limit      : std_logic_vector(31 downto 0);
    tp3_base_low_limit       : std_logic_vector(31 downto 0);
    tp1_pos_level            : std_logic_vector(31 downto 0);
    tp2_pos_level            : std_logic_vector(31 downto 0);
    tp3_pos_level            : std_logic_vector(31 downto 0);
    tp1_neg_level            : std_logic_vector(31 downto 0);    
    tp2_neg_level            : std_logic_vector(31 downto 0);    
    tp3_neg_level            : std_logic_vector(31 downto 0);             
    beamaccum_limit_hr       : std_logic_vector(31 downto 0);
    beamhigh_limit           : std_logic_vector(31 downto 0);
    baseline_low_limit       : std_logic_vector(31 downto 0);
    baseline_high_limit      : std_logic_vector(31 downto 0); 
    charge_calibration       : std_logic_vector(31 downto 0); 
    accum_q_min              : std_logic_vector(31 downto 0);
    accum_length             : std_logic_vector(31 downto 0);  
    crc32_eeprom             : std_logic_vector(31 downto 0);
    crc32_calc               : std_logic_vector(31 downto 0); 
    --beamaccum_limit_calc     : std_logic_vector(31 downto 0);             
end record eeprom_parameters_type;



type pulse_stats_type is record
    baseline     : std_logic_vector(15 downto 0);
    integral     : std_logic_vector(31 downto 0);
    peak         : std_logic_vector(16 downto 0);
    peak_index   : std_logic_vector(31 downto 0);
    peak_found   : std_logic;
    threshold    : std_logic_vector(15 downto 0);
    fwhm         : std_logic_vector(15 downto 0);
end record pulse_stats_type;

type pulse_stats_array is array(0 to 4) of pulse_stats_type;


type i2c_regs_type is record
   temp0 : std_logic_vector(15 downto 0);
   temp1 : std_logic_vector(15 downto 0);
   temp2 : std_logic_vector(15 downto 0);
   temp3 : std_logic_vector(15 downto 0);
   Vreg0 : std_logic_vector(15 downto 0);
   Vreg1 : std_logic_vector(15 downto 0);
   Vreg2 : std_logic_vector(15 downto 0);
   Vreg3 : std_logic_vector(15 downto 0);
   Vreg4 : std_logic_vector(15 downto 0);
   Vreg5 : std_logic_vector(15 downto 0);
   Vreg6 : std_logic_vector(15 downto 0);
   Vreg7 : std_logic_vector(15 downto 0);
   Ireg0 : std_logic_vector(15 downto 0);
   Ireg1 : std_logic_vector(15 downto 0);
   Ireg2 : std_logic_vector(15 downto 0);
   Ireg3 : std_logic_vector(15 downto 0);
   Ireg4 : std_logic_vector(15 downto 0);
   Ireg5 : std_logic_vector(15 downto 0);
   Ireg6 : std_logic_vector(15 downto 0);
   Ireg7 : std_logic_vector(15 downto 0);
end record i2c_regs_type;



end acmi_package;

