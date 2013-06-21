
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;

entity debff is

  generic(
    CNTR_SIZE : integer := 19
  ); -- counter size; 19 bits, 50MHz => 10.5ms

  port (
    clk_in           : in  std_logic;
    button_in        : in  std_logic;
    button_out       : out std_logic
  );
end entity debff;
