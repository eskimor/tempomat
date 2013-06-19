
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;

-- ROT knob buffer
entity rot_buf is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;

    rot_a_i          : in  std_logic;
    rot_b_i          : in  std_logic;

    value_out        : out data_t
  );
end entity rot_buf;
