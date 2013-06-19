
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;

-- DDR memory:
entity tempomat_memory is
  port (
    rst_in           : in  std_logic;
    clk_in           : in  std_logic;

    data_out         : out data_t; -- 8 bits required.
    addr_in          : in  addr_t  -- only 5 bits required for our 20 byte program.
  );
end entity tempomat_memory;
