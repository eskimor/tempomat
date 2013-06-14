library ieee;
use ieee.std_logic_1164.all;

entity lcd_fifo is
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
end lcd_fifo;
