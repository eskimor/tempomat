--------------------------------------------------------------------------------
--
--                _     ___ ____        _          _                
--               | |   |_ _/ ___|      | |    __ _| |__   ___  _ __ 
--               | |    | |\___ \ _____| |   / _` | '_ \ / _ \| '__|
--               | |___ | | ___) |_____| |__| (_| | |_) | (_) | |   
--               |_____|___|____/      |_____\__,_|_.__/ \___/|_|   
--
--
--                               LIS - Laborübung
--
--------------------------------------------------------------------------------
--
--                              Copyright (C) 2005-2012
--
--                      ICT - Institute of Computer Technology    
--                    TU Vienna - Technical University of Vienna
--
--------------------------------------------------------------------------------
--
--  NAME:           Top Level Design
--  UNIT:           Top
--  VHDL:           Architecture
--
--  Author:         nachtnebel
--
--------------------------------------------------------------------------------
--
--  Description:
--
--    Top level architecture used for laboratory designs.
--
--    Instantiiert das Design und die LCD Anzeige.
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.comp_pack.all;

architecture struc of top is

  signal s_clk       : std_logic;
  signal s_reset     : std_logic;

  signal s_rot_a_deb : std_logic;
  signal s_rot_b_deb : std_logic;
  signal s_rot_knobv : data_t;

  signal s_lcd_enab  : std_logic;
  signal s_lcd_data  : data_t;

  signal s_lcd_db    : std_logic_vector(7 downto 0);
  signal s_lcd_rs    : std_logic;
  signal s_lcd_en    : std_logic;
  signal s_lcd_rw    : std_logic;

begin

  s_clk <= sysclk_i;

--  i_debounce_reset : debounce
--  port map (
--    clk_in     => s_clk,
--    button_in  => rot_center_i,
--    button_out => s_reset
--  );

--  s_reset_n <= not(s_reset);

  rstsyn : process (s_clk)
  begin
    s_reset <= rot_center_i;
  end process rstsyn;


  i_debounce_rota : debff
  port map (
    rst_in     => s_reset,
    clk_in     => s_clk,
    button_in  => rot_a_i,
    button_out => s_rot_a_deb
  );


  i_debounce_rotb : debff
  port map (
    rst_in   => s_reset,
    clk_in     => s_clk,
    button_in  => rot_b_i,
    button_out => s_rot_b_deb
  );


  i_rot_buf : rot_buf
  port map (
    rst_in    => s_reset,
    clk_in    => s_clk,
    rot_a_i   => s_rot_a_deb,
    rot_b_i   => s_rot_b_deb,
    value_out => s_rot_knobv
  );


  i_tempomat_cpu : tempomat_cpu
  port map (
    rst_in          => s_reset,
    clk_in          => s_clk,

    wheel_knob_in   => s_rot_knobv,
    display_out     => s_lcd_data,
    display_en_out  => s_lcd_enab
  );


  i_lcd_core : lcd_core
  port map (
    clk_i      => s_clk,
    reset_n_i  => s_reset,

    lcd_cs_i   => s_lcd_enab,
    lcd_data_i => s_lcd_data,

    lcd_data_o => s_lcd_db,
    lcd_rs_o   => s_lcd_rs,
    lcd_en_o   => s_lcd_en,
    lcd_rw_o   => s_lcd_rw
  );

  lcd_db_io <= s_lcd_db when (s_lcd_rw = '0') else (others => 'Z');
  lcd_rs_o  <= s_lcd_rs;
  lcd_en_o  <= s_lcd_en;
  lcd_rw_o  <= s_lcd_rw;

end architecture struc;
