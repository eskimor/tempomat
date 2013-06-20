
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;

entity debounce is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;

    button_in        : in  std_logic;
    button_out       : out std_logic
  );
end entity debounce;
