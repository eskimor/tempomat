
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;

entity tempomat_cpu is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;

    data_in          : in  data_t; -- 8 bits required.
    addr_out         : out addr_t; -- only 5 bits required for our 20 byte program.

    wheel_knob_in    : in  data_t;
    display_out      : out data_t;
    display_en_out   : out std_logic
  );
end entity tempomat_cpu;
