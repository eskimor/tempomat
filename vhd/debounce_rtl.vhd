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

architecture debounce of debounce is
begin
    debounce : process(clk_in, button_in) is
        variable pressed : std_logic := '0';
        variable waiting : std_logic := '0';
        variable counter : integer := 0;
        variable count_to : integer := 0;
        variable old_value : std_logic := '0';
    begin
        if rst_in = '0' then
          button_out <= '0';
        elsif clk_in'event and clk_in = '1' then
            if waiting = '1'
            then
                counter := counter + 1;
                if counter = count_to 
                then
                    waiting := '0';
                end if;
            else
                waiting := '1';
                if pressed = '0'
                then
                    pressed := '1';
                    old_value := button_in;
                    count_to := 50; -- 1 us
                else
                    pressed := '0';
                    if old_value = button_in -- Check that signal is stable
                    then
                        button_out <= button_in; -- Write it out
                        count_to := 5000000; -- block presses for 100 ms.
                    else -- Not yet ready, wait again:
                        count_to := 50; -- 1 us
                    end if;
                end if;
            end if;
        end if;
    end process debounce;
end debounce;
