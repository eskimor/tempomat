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
--  NAME:           tempomat cpu
--  VHDL:           Architecture
--
--  Author:         Robert Klotzner
--
--------------------------------------------------------------------------------
--
--  Description:
--  CPU without memory.
--
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.comp_pack.all;

architecture impl of tempomat_cpu is
--    type register_t is natural range 0 to 255; -- moved to comp_pack

    function hex_to_ascii (constant v : in std_logic_vector ) return data_t is
        variable buf : natural range 0 to 15;
        variable result : natural range 0 to 71;
    begin
        buf := to_integer( unsigned(v) );
        if buf <= 9
        then
            result := buf + 48; -- 48 is 0 in ASCII
        else
            buf := buf-10;
            result := buf + 65; -- 65 is A in ASCII (97 would be a)
        end if;
        return data_t( to_unsigned(result, data_t'length) );
    end function hex_to_ascii;

begin

    cpu_cycle: process(rst_in, clk_in) is
        variable addr : natural range 0 to 20;
        variable running : std_logic; -- Whether the "pipeline" is full or not.
        variable ddr_buf : data_t;

        variable instr : commands;

        variable accu : natural range 0 to 255;
        variable soll : natural range 0 to 255; -- "Sollwert"
        variable cmp_buf : natural range 0 to 255; -- internal register
        variable carry : std_logic;
        variable zero : std_logic;


        variable accu_as_data_t : data_t;


        -- Wait related:
        variable wait_cnt : natural range 0 to 50000;
        constant ms_time : natural := 50000;

        variable wait_ms_cnt : natural range 0 to 255;
        variable do_wait : std_logic;
    begin
        if rst_in = '0'
        then
            accu := 0;
            soll := 0;
            addr := 0;
            running := '0';
            ddr_buf := (others => '0');

            addr_out <= (others => '0');
            display_en_out <= '0';

            carry := '0';
            zero := '0';

            -- Wait related:
            wait_cnt := 0;
            do_wait := '0';
            wait_ms_cnt := 0;

        elsif clk_in'event
        then
            if clk_in = '1' and running = '1' and do_wait = '0'
            then
                display_en_out <= '0'; -- Disable, might be overriden depending on command.
                instr := commands'val( to_integer( unsigned(ddr_buf) ) );
                case instr is
                    when IN_C =>
                        accu := register_t( to_integer( unsigned(wheel_knob_in) ) );
                    when OUTL_C =>
                        accu_as_data_t := data_t( to_unsigned(accu, data_t'length) );
                        display_out <= hex_to_ascii(accu_as_data_t(3 downto 0)); 
                        display_en_out <= '1';
                    when OUTH_C =>
                        accu_as_data_t := data_t( to_unsigned(accu, data_t'length) );
                        display_out <= hex_to_ascii(accu_as_data_t(7 downto 4)); 
                        display_en_out <= '1';
                    when OUTCR_C =>
                        display_out <= data_t( to_unsigned(16#0D#, data_t'length) );
                        display_en_out <= '1';
                    when LDI_C =>
                        addr := addr + 1; -- Next byte is no instruction, skip it
                        accu := register_t( to_integer( unsigned(data_in) ) );
                    when INC_C => accu := accu + 1;
                    when DEC_C => accu := accu -1;
                    when STR_C => soll := accu;
                    when LDR_C => accu := soll;
                    when CMP_C => 
                        zero := '0';
                        carry := '0';
                        if accu = soll
                        then
                            zero := '1';
                        elsif accu > soll
                        then
                            carry := '1';
                        end if;
                    when JC_C =>
                        addr := addr + 1; -- Next byte is no instruction, skip it
                        if carry = '1'
                        then
                            addr := to_integer ( unsigned(data_in) ); -- Or even load new address.
                        end if;
                    when JZ_C =>
                        addr := addr + 1; -- Next byte is no instruction, skip it
                        if zero = '1'
                        then
                          addr := to_integer ( unsigned(data_in) ); -- Or even load new address.
                        end if;
                    when JMP_C =>
                        addr := to_integer ( unsigned(data_in) ); -- Load new address
                    when WAIT_C =>
                        do_wait := '1';
                        addr := addr + 1; -- Drop the wait count
--                        wait_ms_cnt := natural range 0 to 255 (data_in);
                        wait_ms_cnt := to_integer( unsigned(data_in) );
                end case;
                -- DDR memory read next value already on two byte instructions. (We have to execute one instruction per cycle):
                addr_out <= addr_t( to_unsigned(addr, addr_t'length) );
            elsif clk_in = '0' and do_wait = '0'
            then
                if running = '0'
                then
                    running := '1';
                    wait_ms_cnt := 0;
                    do_wait := '1'; -- Wait for half a cycle 
                    addr_out <= addr_t( to_unsigned(addr, addr_t'length) ); -- Load first address.
                else -- Data is ready now
                    ddr_buf := data_in;
                    addr := addr + 1;
                    addr_out <= addr_t( to_unsigned(addr, addr_t'length) );
                end if;
            elsif clk_in = '1' and do_wait = '1'
            then
                if(wait_ms_cnt > 0)
                then
                    if wait_cnt = ms_time
                    then
                        wait_ms_cnt := wait_ms_cnt - 1;
                        wait_cnt := 0;
                    else
                        wait_cnt := wait_cnt + 1;
                    end if;
                else
                    do_wait := '0'; -- Continue with "elsif clk_in = '0' ..."
                end if;
            end if;
        end if;
    end process cpu_cycle;
end impl;
