library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



library UNISIM;
use UNISIM.VComponents.all;

entity check_testpulse is
  port (
   clk          : in  std_logic;
   gate         : in std_logic;                  
   baseline     : in std_logic_vector(15 downto 0);
   integral     : in std_logic_vector(31 downto 0);
   integral_val : in std_logic;
   test_pulse_val : out std_logic;
   test_pulse_baseline : out std_logic_vector(15 downto 0);
   test_pulse_integral : out std_logic_vector(31 downto 0)              
  );    
end check_testpulse;


architecture behv of check_testpulse is
    
  type     state_type is (IDLE, TRIGGERED, WAIT_GATEDONE); 
  signal   state            : state_type  := idle;
  
  
  signal integral_val_lat   : std_logic;

  
begin  


process (clk)
  begin  
    if (rising_edge(clk)) then
      case state is
         when IDLE =>   
           test_pulse_val <= '0';
           integral_val_lat <= '0';
           if (gate = '1') then
              state <= triggered;
           end if;

         when TRIGGERED =>  
           if (gate = '0') then
           	 if (integral_val_lat = '1') then
		       test_pulse_baseline <= baseline;
               test_pulse_integral <= integral;      
             else
  		       test_pulse_baseline <= 16d"0";
               test_pulse_integral <= 32d"0";               
		     end if;
		     state <= idle; 
		   end if; 
	       if (integral_val = '1') then 
	         integral_val_lat <= '1';
		   end if;
			   
--         when WAIT_GATEDONE =>  
--		   if (gate = '0') then
--		     if (integral_val_lat = '1') then
--		       test_pulse_baseline <= baseline;
--               test_pulse_integral <= integral;      
--             else
--  		       test_pulse_baseline <= 16d"0";
--               test_pulse_integral <= 32d"0";               
--		     end if;  
--		   state <= idle;
--		   end if;			   		   
		   	   			   
         when others =>
           state <= IDLE;
       end case;
     end if; 
  end process;


  
end behv;
