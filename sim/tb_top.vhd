library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;


entity tb_top is
end tb_top;


architecture sim of tb_top is

  signal s_reset_n    : std_logic;
  signal s_clk        : std_logic;

  signal s_lcd_db     : std_logic_vector(7 downto 0);
  signal s_lcd_rs     : std_logic;
  signal s_lcd_en     : std_logic;
  signal s_lcd_rw     : std_logic;

  signal s_rot_center : std_logic;
  signal s_rot_a      : std_logic;
  signal s_rot_b      : std_logic;

begin  -- sim

  i_top : top
  port map (
    sysclk_i     => s_clk,

    lcd_db_io    => s_lcd_db,
    lcd_rs_o     => s_lcd_rs,
    lcd_en_o     => s_lcd_en,
    lcd_rw_o     => s_lcd_rw,

    rot_center_i => s_rot_center,
    rot_a_i      => s_rot_a,
    rot_b_i      => s_rot_b
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
    s_rot_center <= '1';
    s_rot_a <= '0';
    s_rot_b <= '0';
    wait for 500 us;
    s_rot_center <= '0';
    wait for 1300 us;
    s_rot_center <= '1';
    wait for 700 us;
    s_rot_a <= '0';
    s_rot_b <= '1';

    wait for 500 us;
    s_rot_a <= '0';
    s_rot_b <= '0';
    wait for 700 us;
    s_rot_a <= '1';
    s_rot_b <= '0';
    wait for 500 us;
    s_rot_a <= '1';
    s_rot_b <= '1';
    wait for 700 us;
    s_rot_a <= '0';
    s_rot_b <= '1';


    wait for 500 us;
    s_rot_a <= '0';
    s_rot_b <= '0';
    wait for 700 us;
    s_rot_a <= '1';
    s_rot_b <= '0';
    wait for 500 us;
    s_rot_a <= '1';
    s_rot_b <= '1';
    wait for 700 us;
    s_rot_a <= '0';
    s_rot_b <= '1';


    wait for 500 us;
    s_rot_a <= '0';
    s_rot_b <= '0';
    wait for 700 us;
    s_rot_a <= '1';
    s_rot_b <= '0';
    wait for 500 us;
    s_rot_a <= '1';
    s_rot_b <= '1';
    wait for 700 us;
    s_rot_a <= '0';
    s_rot_b <= '1';


    wait for 500 us;
    s_rot_a <= '0';
    s_rot_b <= '0';
    wait for 700 us;
    s_rot_a <= '1';
    s_rot_b <= '0';
    wait for 500 us;
    s_rot_a <= '1';
    s_rot_b <= '1';
    wait for 700 us;
    s_rot_a <= '0';
    s_rot_b <= '1';


    wait for 500 us;
    s_rot_a <= '0';
    s_rot_b <= '0';
    wait for 700 us;
    s_rot_a <= '1';
    s_rot_b <= '0';
    wait for 500 us;
    s_rot_a <= '1';
    s_rot_b <= '1';
    wait for 700 us;
    s_rot_a <= '0';
    s_rot_b <= '1';







    wait;
  end process test_data_gen;


end architecture sim;
