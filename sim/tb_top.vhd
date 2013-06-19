library ieee;
use ieee.std_logic_1164.all;

entity tb_top is
end tb_top;

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.comp_pack.all;

architecture sim of tb_top is

  signal s_clk        : std_logic;
  signal s_reset_n    : std_logic;

  signal s_lcd_db     : std_logic_vector(7 downto 0);
  signal s_lcd_rs     : std_logic;
  signal s_lcd_en     : std_logic;
  signal s_lcd_rw     : std_logic;

  signal s_btn_east   : std_logic;
  signal s_btn_north  : std_logic;
  signal s_btn_south  : std_logic;
  signal s_btn_west   : std_logic;

  signal s_rot_center : std_logic;
  signal s_rot_a      : std_logic;
  signal s_rot_b      : std_logic;

  signal s_switch     : std_logic_vector(3 downto 0);

  signal s_led        : std_logic_vector(7 downto 0);

begin  -- sim
  
  clk_gen: process
  begin  -- process pci_clk_gen
    s_clk <= '0';
    wait for 10 ns;
    s_clk <= '1';
    wait for 10 ns;
  end process clk_gen;

  reset_gen: process
  begin  -- process reset_gen
    s_reset_n <= '0';
    wait for 123 ns;
    s_reset_n <= '1';
    wait for 1 sec;
  end process reset_gen;


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

  s_lcd_db    <= (others => 'Z');

  s_btn_east  <= '0';
  s_btn_north <= '0';
  s_btn_south <= '0';
  s_btn_west  <= '0';

  s_rot_center <= '0';
  s_rot_a      <= '1';
  s_rot_b      <= '1';

  s_switch(0) <= s_reset_n;
  s_switch(1) <= '0';
  s_switch(2) <= '0';
  s_switch(3) <= '0';

end sim;
