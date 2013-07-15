library ieee;
use ieee.std_logic_1164.all;

package comp_pack is

  subtype register_t is natural range 0 to 255;
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


  component debff is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;
    button_in        : in  std_logic;
    button_out       : out std_logic
  );
  end component debff;


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

    wheel_knob_in    : in  data_t;
    display_out      : out data_t;
    display_en_out   : out std_logic
  );
  end component tempomat_cpu;


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
