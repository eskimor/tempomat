
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;

entity tempomat_cpu is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;

    wheel_knob_in    : in  data_t;
    display_out      : out data_t;
    display_en_out   : out std_logic
  );
end entity tempomat_cpu;
