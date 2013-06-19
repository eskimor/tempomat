--------------------------------------------------------------------------------
--
--                _     ___ ____        _          _                
--               | |   |_ _/ ___|      | |    __ _| |__   ___  _ __ 
--               | |    | |\___ \ _____| |   / _` | '_ \ / _ \| '__|
--               | |___ | | ___) |_____| |__| (_| | |_) | (_) | |   
--               |_____|___|____/      |_____\__,_|_.__/ \___/|_|   
--
--
--                               LIS - Laborübung
--
--------------------------------------------------------------------------------
--
--                              Copyright (C) 2005-2012
--
--                      ICT - Institute of Computer Technology    
--                    TU Vienna - Technical University of Vienna
--
--------------------------------------------------------------------------------
--
--  NAME:           Components Package
--  UNIT:           com_pack
--  VHDL:           Package
--
--  Author:         nachtnebel
--
--------------------------------------------------------------------------------
--
--  Description:
--
--    All entities of design in component form in one package.
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package comp_pack is

  subtype register_t is natural range 0 to 255;


  subtype addr_t is std_logic_vector(4 downto 0);
  subtype data_t is std_logic_vector(7 downto 0);

  constant CMD_IN    : addr_t := "00001";
  constant CMD_OUTL  : addr_t := "00010";
  constant CMD_OUTH  : addr_t := "00011";
  constant CMD_OUTCR : addr_t := "00100";
  constant CMD_LDI   : addr_t := "00101";
  constant CMD_INC   : addr_t := "00110";
  constant CMD_DEC   : addr_t := "00111";
  constant CMD_STR   : addr_t := "01000";
  constant CMD_LDR   : addr_t := "01001";
  constant CMD_CMP   : addr_t := "01010";
  constant CMD_JC    : addr_t := "01011";
  constant CMD_JZ    : addr_t := "01100";
  constant CMD_JMP   : addr_t := "01101";
  constant CMD_WAIT  : addr_t := "01110";



  -- Should go to package (cpu uses it too!):
  type commands is (
    IN_C,
    OUTL_C,
    OUTH_C,
    OUTCR_C,
    LDI_C, -- Load immediate
    INC_C,
    DEC_C,
    STR_C, -- Store register
    LDR_C, -- Load register
    CMP_C,
    JC_C,
    JZ_C,
    JMP_C,
    WAIT_C
  );



  -- end common stuff


  component top is
  port (
    sysclk_i        : in  std_logic;  	-- system clock, 50 MHz

    -- LCD Interface
    lcd_db_io       : inout std_logic_vector(7 downto 0);
    lcd_rs_o        : out std_logic;
    lcd_en_o        : out std_logic;
    lcd_rw_o        : out std_logic;

    -- Push Buttons
    btn_east_i      : in  std_logic;
    btn_north_i     : in  std_logic;
    btn_south_i     : in  std_logic;
    btn_west_i      : in  std_logic;

    -- Rotary Knob (ROT)
    rot_center_i    : in  std_logic;
    rot_a_i         : in  std_logic;
    rot_b_i         : in  std_logic;

    -- Mechanical Switches
    switch_i        : in  std_logic_vector(3 downto 0);

    -- LEDs
    led_o           : out std_logic_vector(7 downto 0)
  );
  end component top;

  component lcd_core is
  port (
    clk_i          : in  std_logic;
    reset_n_i      : in  std_logic;

    lcd_cs_i       : in  std_logic;
    lcd_data_i     : in  std_logic_vector (7 downto 0);

    lcd_data_o     : out std_logic_vector (7 downto 0);
    lcd_rs_o       : out std_logic;
    lcd_en_o       : out std_logic;
    lcd_rw_o       : out std_logic
  );
  end component lcd_core;

  component lcd_fifo is
  port (
    clk    : in  std_logic;
    rst_n  : in  std_logic;

    wr_en  : in  std_logic;
    din    : in  std_logic_vector (7 downto 0);

    rd_en  : in  std_logic;
    dout   : out std_logic_vector (7 downto 0);

    full   : out std_logic;
    empty  : out std_logic
  );
  end component lcd_fifo;

  component lcd_display is
  port
  (
    clk_i          : in  std_logic;
    reset_n_i      : in  std_logic;

    lcd_cs_o       : out std_logic;
    lcd_data_o     : out std_logic_vector (7 downto 0)
  );
  end component lcd_display;


end comp_pack;
