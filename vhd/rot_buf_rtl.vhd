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

architecture rot_buf of rot_buf is
    
    signal rot_right : std_logic;
    signal rot_left : std_logic;
begin
  read_value: process(clk_in, rst_in) is
    variable value : natural range 0 to 255;
    variable rot_a_old : std_logic;
    variable rot_b_old : std_logic;
  begin
    if rst_in = '0'
    then
        value := 0;
        value_out <= (others <= '0');
        rot_a_old := rot_a_i;
        rot_b_old := rot_b_i;

    elsif clk_in'event and clk_in = '1' 
    then
        if rot_a_i = '1' and rot_a_old = '0' and rot_b_i = '0' and value /= 255
        then
            value := value + 1;
        elsif rot_b_i = '1' and rot_b_old = '0' and rot_a_i = '0' and value /= 0
        then
            value := value - 1;
        end if;
        rot_a_old := rot_a_in;
        rot_b_old := rot_b_in;
        value_out <= data_t(to_unsigned(value, data_t'length));
    end if;
  end process read_value;
end rot_buf;
