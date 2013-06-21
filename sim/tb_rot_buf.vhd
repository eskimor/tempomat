library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;


entity tb_rot_buf is
end tb_rot_buf;


architecture sim of tb_rot_buf is

  signal s_reset_n    : std_logic;
  signal s_clk        : std_logic;

  signal s_rot_a      : std_logic;
  signal s_rot_b      : std_logic;
  signal s_rot_out    : data_t;

begin

  i_rot_buf : rot_buf
  port map (
    rst_in      => s_reset_n,
    clk_in      => s_clk,

    rot_a_i     => s_rot_a,
    rot_b_i     => s_rot_b,

    value_out   => s_rot_out
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
-- steigende flanke auf A, solange B logisch 0 => pos nach rechts gedreht
-- steigende flanke auf B, solange A logisch 0 => pos nach links gedreht
-- run 10 ms

    s_reset_n <= '1';
    s_rot_a <= 'Z';
    s_rot_b <= 'Z';
    wait for 9 us;
    s_reset_n <= '0'; -- reset
    wait for 11 us;
    s_reset_n <= '1'; -- reset off
    wait for 50 us;
    s_rot_a <= '0';
    s_rot_b <= '0';

    wait for 50 us;
    s_rot_a <= '0';
    s_rot_b <= '0';

    for i in 1 to 30 loop 
      wait for 70 us;
      s_rot_a <= '1';
      wait for 50 us;
      s_rot_a <= '0';
    end loop;

    wait for 100 us;

    wait for 50 us;
    s_rot_a <= '0';
    s_rot_b <= '0';

    for i in 1 to 50 loop 
      wait for 70 us;
      s_rot_b <= '1';
      wait for 50 us;
      s_rot_b <= '0';
    end loop;

    wait;
  end process test_data_gen;


end architecture sim;