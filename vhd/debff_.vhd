library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;

entity debff is

  generic(
    CNTR_SIZE : integer := 15
  ); -- counter size; 19 bits, 50MHz => 10.5ms; 15/16 bits fuer ~1ms

  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;
    button_in        : in  std_logic;
    button_out       : out std_logic
  );

end entity debff;
