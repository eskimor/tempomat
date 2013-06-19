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
--  NAME:           tempomat rot knob buffer
--  VHDL:           Architecture
--
--  Author:         Robert Klotzner
--
--------------------------------------------------------------------------------
--
--  Description:
--  ROT knob for our funny CPU.
--
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.comp_pack.all;

architecture rot_knob_debounced of rot_knob_buffer is
    
    signal rot_right : std_logic;
    signal rot_left : std_logic;
begin
  read_value: process(clk_in, rst_in) is
    variable value : natural range 0 to 255;
    variable doSleep : std_logic;
  begin
    if rst_in = '0'
    then
        value := 0;
        value_out <= (others <= '0');
        doSleep := '0'

    elsif clk_in'event and clk_in = '1' and doSleep /= '0' 
    then
        if rot_a_i =     
        addr := to_integer ( unsigned(addr_in) );

    elsif doSleep = '1'
    end if;
  end process mem_cycle;
  detect_value: process(rot_a_i, rot_b_i) is
  begin
  end process detect_value;
end impl;
