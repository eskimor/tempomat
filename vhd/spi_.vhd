library ieee;
use ieee.std_logic_1164.all;

entity spi_ifc is
  port (
    clk_i       : in std_logic;
    reset_n_i   : in std_logic;

    -- Internal Parallel ADC, DAC Interfaces

    direction_i     : in  std_logic;
    channel_o       : out std_logic_vector (2 downto 0);

    adc_ch1_o       : out std_logic_vector (13 downto 0);
    adc_ch1_valid_o : out std_logic;

    adc_ch2_o       : out std_logic_vector (13 downto 0);
    adc_ch2_valid_o : out std_logic;
    adc_ch2_ch_o    : out std_logic_vector (2 downto 0);

    dac_ch1_i       : in std_logic_vector (11 downto 0);
    dac_ch1_valid_i : in std_logic;

    dac_ch2_i       : in std_logic_vector (11 downto 0);
    dac_ch2_valid_i : in std_logic;

    dac_ch3_i       : in std_logic_vector (11 downto 0);
    dac_ch3_valid_i : in std_logic;

    dac_ch4_i       : in std_logic_vector (11 downto 0);
    dac_ch4_valid_i : in std_logic;

    dac_ready_o     : out std_logic;

    amp_ch1_i       : in std_logic_vector (3 downto 0);
    amp_ch2_i       : in std_logic_vector (3 downto 0);

    -- External SPI Interface to ADC, DAC and Amplifier

    spi_clk_o   : out std_logic;
    spi_dat_o   : out std_logic;
    
    ad_conv_o   : out std_logic;
    adc_dat_i   : in  std_logic;

    dac_clr_n_o : out std_logic;
    dac_cs_n_o  : out std_logic;
    dac_dat_i   : in  std_logic;

    amp_shdn_o  : out std_logic;
    amp_cs_n_o  : out std_logic;
    amp_dat_i   : in  std_logic
  );
end entity spi_ifc;
