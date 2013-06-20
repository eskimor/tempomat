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


  component debounce is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;
    button_in        : in  std_logic;
    button_out       : out std_logic
  );
  end component debounce;


  component rot_buf is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;
    rot_a_i          : in  std_logic;
    rot_b_i          : in  std_logic;
    value_out        : out data_t
  );
  end component rot_buf;


  component tempomat_cpu is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;

    data_in          : in  data_t; -- 8 bits required.
    addr_out         : out addr_t; -- only 5 bits required for our 20 byte program.

    wheel_knob_in    : in  data_t;
    display_out      : out data_t;
    display_en_out   : out std_logic
  );
  end component tempomat_cpu;


  component tempomat_memory is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;

    data_out         : out data_t; -- 8 bits required.
    addr_in          : in  addr_t  -- only 5 bits required for our 20 byte program.
  );
  end component tempomat_memory;


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


  component top is
  port (
    sysclk_i        : in    std_logic;  	-- system clock, 50 MHz

    -- LCD Interface
    lcd_db_io       : inout std_logic_vector(7 downto 0);
    lcd_rs_o        : out   std_logic;
    lcd_en_o        : out   std_logic;
    lcd_rw_o        : out   std_logic;

    -- Rotary Knob (ROT)
    rot_center_i    : in    std_logic;
    rot_a_i         : in    std_logic;
    rot_b_i         : in    std_logic
  );
  end component top;


end comp_pack;

