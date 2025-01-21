library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;



entity kria_comm_wrapper is

port (
    clk                        : in std_logic;
    reset                      : in std_logic;
    gtp_refclk_n               : in std_logic;
    gtp_refclk_p               : in std_logic;
    q0_clk0_refclk_out         : out std_logic;   
    gtp_tx_data                : in std_logic_vector(31 downto 0);
    gtp_tx_data_enb            : in std_logic;
    gtp_rx_clk                 : out std_logic;
    gtp_rx_data                : out std_logic_vector(31 downto 0);
    RXN_IN                     : in std_logic;
    RXP_IN                     : in std_logic;
    TXN_OUT                    : out std_logic;
    TXP_OUT                    : out std_logic
);
end kria_comm_wrapper;
    
    
    
architecture behv of kria_comm_wrapper is


COMPONENT tx_data_fifo
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    rd_data_count : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) 
  );
END COMPONENT;




  type     state_type is (IDLE, ACTIVE); 
  signal   state            : state_type;

  signal gt0_rxdata_i          : std_logic_vector(31 downto 0);
  signal gt0_rxcharisk_i       : std_logic_vector(3 downto 0);
  signal gt0_txdata_i          : std_logic_vector(31 downto 0);
  signal gt0_txcharisk_i       : std_logic_vector(3 downto 0);
 
  signal gt0_txusrclk_i        : std_logic; 
  signal gt0_txusrclk2_i       : std_logic; 
  signal gt0_rxusrclk_i        : std_logic; 
  signal gt0_rxusrclk2_i       : std_logic; 
  
  signal gt0_rxresetdone        : std_logic;
 
  signal sys_clk                : std_logic;
  signal pll_locked             : std_logic;
  
  signal gth_data               : std_logic_vector(31 downto 0);
  signal gth_data_enb           : std_logic;
  

  signal rx_data                : std_logic_vector(31 downto 0);
  
  signal tx_fifo_dout   : std_logic_vector(31 downto 0);
  signal tx_fifo_rden   : std_logic;
  signal tx_fifo_empty  : std_logic;
  signal tx_fifo_rddatacnt : std_logic_vector(15 downto 0);
  


   attribute mark_debug                  : string;
   attribute mark_debug of gt0_txdata_i : signal is "true";    
   attribute mark_debug of gt0_txcharisk_i : signal is "true";
   attribute mark_debug of gt0_rxdata_i : signal is "true";    
   attribute mark_debug of gt0_rxcharisk_i : signal is "true";
   attribute mark_debug of rx_data : signal is "true";
   attribute mark_debug of state: signal is "true";
   attribute mark_debug of tx_fifo_dout: signal is "true";
   attribute mark_debug of tx_fifo_rden: signal is "true"; 
   attribute mark_debug of tx_fifo_empty: signal is "true";
   attribute mark_debug of tx_fifo_rddatacnt: signal is "true";
   

begin


--test_gth:  entity work.gen_testdata
--  port map ( 
--	clk => gt0_txusrclk2_i, 
--    rst => reset, 
--    gth_tx_enb => '1', 
--    gth_data => gth_data, 
--    gth_data_enb => gth_data_enb 	
--);


--gt0_txdata_i(7 downto 0) <= x"BC" when (gth_data_enb = '0') else gth_data(7 downto 0);
--gt0_txdata_i(31 downto 8) <= x"505152" when (gth_data_enb = '0') else gth_data(31 downto 8);

--gt0_txcharisk_i <= x"1" when (gth_data_enb = '0') else x"0";




gtp_rx_data <= rx_data;
gtp_rx_clk <= gt0_rxusrclk2_i;


send_kria_fifo : tx_data_fifo
  port map (
    rst => reset,
    wr_clk => clk,
    din => gtp_tx_data,
    wr_en => gtp_tx_data_enb,  
    rd_clk => gt0_txusrclk2_i,
    rd_en => tx_fifo_rden,
    dout => tx_fifo_dout,
    full => open,
    empty => tx_fifo_empty,
    rd_data_count => tx_fifo_rddatacnt
  );



send_gtp_data: process(gt0_txusrclk2_i)
  begin
    if (rising_edge(gt0_txusrclk2_i)) then
      if (reset = '1') then
        gt0_txdata_i <= x"505152BC";
        gt0_txcharisk_i <= x"1";
        tx_fifo_rden <= '0';
        state <= idle;
      else
        case state is 
          when IDLE =>
            gt0_txdata_i <= x"505152BC";
            gt0_txcharisk_i <= x"1";          
            if (tx_fifo_empty = '0') then
              state <= active;
              tx_fifo_rden <= '1';
            end if;
            
          when ACTIVE =>
            if (tx_fifo_empty = '0') then
              gt0_txdata_i <= tx_fifo_dout;
              gt0_txcharisk_i <= x"0";
              tx_fifo_rden <= '1';
            else
              tx_fifo_rden <= '0';
              state <= idle;
            end if;
         end case;
        end if;
    end if;
end process;






 
 align_rx : entity work.align_rxdata
   port map (
     clk => gt0_rxusrclk2_i,
     rst => gt0_rxresetdone,
     data_in => gt0_rxdata_i,
     charisk_in => gt0_rxcharisk_i,
     data_out => rx_data
 );
 
 
 
 gen_100mhz : entity work.gtp_clk
   port map ( 
     clk_in1 => clk,              
     reset => '0',
     locked => pll_locked,
     clk_out1 => sys_clk
 );
 
 
 
 
 
    
kria_comm_support_i : entity work.kria_comm_support
  generic map (
    EXAMPLE_SIM_GTRESET_SPEEDUP     =>     "TRUE", 
    STABLE_CLOCK_PERIOD             =>      10   
  )
  port map (
    soft_reset_tx_in                =>      reset, 
    soft_reset_rx_in                =>      reset, 
    DONT_RESET_ON_DATA_ERROR_IN     =>      '1', 
    Q0_CLK0_GTREFCLK_PAD_N_IN       =>      gtp_refclk_n, 
    Q0_CLK0_GTREFCLK_PAD_P_IN       =>      gtp_refclk_p, 
    refclk_out                      =>      q0_clk0_refclk_out,
    GT0_TX_MMCM_LOCK_OUT            =>      open, 
    GT0_RX_MMCM_LOCK_OUT            =>      open, 
    GT0_TX_FSM_RESET_DONE_OUT       =>      open, 
    GT0_RX_FSM_RESET_DONE_OUT       =>      open, 
    GT0_DATA_VALID_IN               =>      '1', 
    GT0_TXUSRCLK_OUT                =>      gt0_txusrclk_i,
    GT0_TXUSRCLK2_OUT               =>      gt0_txusrclk2_i,
    GT0_RXUSRCLK_OUT                =>      gt0_rxusrclk_i,
    GT0_RXUSRCLK2_OUT               =>      gt0_rxusrclk2_i,

    ---------------------------- Channel - DRP Ports  --------------------------
    gt0_drpaddr_in                  =>      (others => '0'), --gt0_drpaddr_i,
    gt0_drpdi_in                    =>      (others => '0'), 
    gt0_drpdo_out                   =>      open, 
    gt0_drpen_in                    =>      '0',
    gt0_drprdy_out                  =>      open, 
    gt0_drpwe_in                    =>      '0', 
    --------------------- RX Initialization and Reset Ports --------------------
    gt0_eyescanreset_in             =>      '0',
    gt0_rxuserrdy_in                =>      '1',
    -------------------------- RX Margin Analysis Ports ------------------------
    gt0_eyescandataerror_out        =>      open, 
    gt0_eyescantrigger_in           =>      '0', 
    ------------------ Receive Ports - FPGA RX Interface Ports -----------------
    gt0_rxdata_out                  =>      gt0_rxdata_i,
    ------------------ Receive Ports - RX 8B/10B Decoder Ports -----------------
    gt0_rxchariscomma_out           =>      open, 
    gt0_rxcharisk_out               =>      gt0_rxcharisk_i,
    gt0_rxdisperr_out               =>      open,
    gt0_rxnotintable_out            =>      open,
    ------------------------ Receive Ports - RX AFE Ports ----------------------
    gt0_gtprxn_in                   =>      RXN_IN,
    gt0_gtprxp_in                   =>      RXP_IN,
    -------------- Receive Ports - RX Byte and Word Alignment Ports ------------
    gt0_rxcommadet_out              =>      open,
    gt0_rxmcommaalignen_in          =>      '1', 
    gt0_rxpcommaalignen_in          =>      '1', 
    ------------ Receive Ports - RX Decision Feedback Equalizer(DFE) -----------
    gt0_dmonitorout_out             =>      open, 
    -------------------- Receive Ports - RX Equailizer Ports -------------------
    gt0_rxlpmhfhold_in              =>      '0', 
    gt0_rxlpmlfhold_in              =>      '0', 
    --------------- Receive Ports - RX Fabric Output Control Ports -------------
    gt0_rxoutclkfabric_out          =>      open, 
    ------------- Receive Ports - RX Initialization and Reset Ports ------------
    gt0_gtrxreset_in                =>      '0', 
    gt0_rxlpmreset_in               =>      '0', 
    -------------- Receive Ports -RX Initialization and Reset Ports ------------
    gt0_rxresetdone_out             =>      gt0_rxresetdone, 
    --------------------- TX Initialization and Reset Ports --------------------
    gt0_gttxreset_in                =>      '0', 
    gt0_txuserrdy_in                =>      '1', 
    ------------------ Transmit Ports - FPGA TX Interface Ports ----------------
    gt0_txdata_in                   =>      gt0_txdata_i,
    ------------------ Transmit Ports - TX 8B/10B Encoder Ports ----------------
    gt0_txcharisk_in                =>      gt0_txcharisk_i,
    --------------- Transmit Ports - TX Configurable Driver Ports --------------
    gt0_gtptxn_out                  =>      TXN_OUT,
    gt0_gtptxp_out                  =>      TXP_OUT,
    ----------- Transmit Ports - TX Fabric Clock Output Control Ports ----------
    gt0_txoutclkfabric_out          =>      open, 
    gt0_txoutclkpcs_out             =>      open, 
    ------------- Transmit Ports - TX Initialization and Reset Ports -----------
    gt0_txresetdone_out             =>      open, 
    ------------- COMMON PORTS --------------------
    GT0_PLL0RESET_OUT               =>      open,
    GT0_PLL0OUTCLK_OUT              =>      open,
    GT0_PLL0OUTREFCLK_OUT           =>      open,
    GT0_PLL0LOCK_OUT                =>      open,
    GT0_PLL0REFCLKLOST_OUT          =>      open,    
    GT0_PLL1OUTCLK_OUT              =>      open,
    GT0_PLL1OUTREFCLK_OUT           =>      open,
    sysclk_in                       =>      sys_clk
  );


 

end behv;


