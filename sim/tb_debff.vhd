library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.comp_pack.all;


entity tb_debff is
end tb_debff;


architecture sim of tb_debff is

--  signal s_reset_n    : std_logic;
  signal s_rst        : std_logic;
  signal s_clk        : std_logic;

  signal s_orig       : std_logic;
  signal s_debd       : std_logic;

begin

  i_debff : debff
  port map (
    rst_in      => s_rst,
    clk_in      => s_clk,
    button_in   => s_orig,
    button_out  => s_debd
  );


  clk_gen: process
  begin  -- process pci_clk_gen
    s_clk <= '0';
    wait for 10 ns;
    s_clk <= '1';
    wait for 10 ns;
  end process clk_gen;


  test_data_gen : process
  begin
-- run 10 ms
    s_rst <= 'Z';
    s_orig <= 'Z';
    wait for 500 us;
    s_rst <= '1';
    wait for 500 us;
    s_orig <= '1';
    wait for 500 us;
    s_rst <= '0';
    wait for 1 ms;
    s_rst <= '1';
    wait for 7 ms;

    for i in 1 to 5 loop
      s_orig <= '0';
      wait for 13 us;
      s_orig <= '1';
      wait for 7 us;
    end loop;
    s_orig <= '0';

    wait for 8 ms;

    for i in 1 to 4 loop
      s_orig <= '1';
      wait for 6 us;
      s_orig <= '0';
      wait for 14 us;
    end loop;
    s_orig <= '1';

    wait for 9 ms;

    for i in 1 to 3 loop
      s_orig <= '0';
      wait for 60 us;
      s_orig <= '1';
      wait for 140 us;
    end loop;
    s_orig <= '0';

    wait for 3 ms;

    for i in 1 to 10 loop
      s_orig <= '1';
      wait for 8 us;
      s_orig <= '0';
      wait for 12 us;
    end loop;
    s_orig <= '1';

    wait for 8 ms;

    s_rst <= '0';

    wait;

  end process test_data_gen;

end architecture sim;
