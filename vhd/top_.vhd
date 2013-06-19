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
--                              Copyright (C) 2005
--
--                      ICT - Institute of Computer Technology    
--                    TU Vienna - Technical University of Vienna
--
--------------------------------------------------------------------------------
--
--  NAME:           Top Level Design
--  UNIT:           Top
--  VHDL:           Entity
--
--  Author:         nachtnebel
--
--------------------------------------------------------------------------------
--
--  Description:
--
--    Top level entity used for laboratory designs.
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    sysclk_i        : in  std_logic;  	-- system clock, 100 MHz

    -- LCD Interface
    lcd_db_io       : inout std_logic_vector(7 downto 0);
    lcd_rs_o        : out std_logic;
    lcd_en_o        : out std_logic;
    lcd_rw_o        : out std_logic;

--    -- Push Buttons
--    btn_east_i      : in  std_logic;
--    btn_north_i     : in  std_logic;
--    btn_south_i     : in  std_logic;
--    btn_west_i      : in  std_logic;

    -- Rotary Knob (ROT)
    rot_center_i    : in  std_logic; -- used as reset
    rot_a_i         : in  std_logic;
    rot_b_i         : in  std_logic

--    -- Mechanical Switches
--    switch_i        : in  std_logic_vector(3 downto 0);

--    -- LEDs
--    led_o           : out std_logic_vector(7 downto 0)
  );
end top;
