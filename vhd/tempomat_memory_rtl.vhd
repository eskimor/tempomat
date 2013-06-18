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
--  NAME:           tempomat DDR memory
--  VHDL:           Architecture
--
--  Author:         Robert Klotzner
--
--------------------------------------------------------------------------------
--
--  Description:
--  DDR memory for our funny CPU.
--
--
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.comp_pack.all;

-- Memory:
-- 0:  LDI
-- 1:  0
-- 2:  STR
-- 3:  OUTCR
-- 4:  OUTH
-- 5:  OUTL
-- 6:  IN
-- 7:  CMP
-- 8:  LDR
-- 9:  JZ
-- 10: 17
-- 11: JC
-- 12: 16
-- 13: DEC
-- 14: JMP
-- 15: 17
-- 16: INC
-- 17: WAIT
-- 18: 200
-- 19: JMP
-- 20: 2

architecture tempomat_commands of tempomat_memory is

begin
    mem_cycle: process(clk_in) is
        variable addr : natural range 0 to 20;
    begin
        if clk_in'event 
            addr := natural range 0 to 20(addr_in);
            case addr is
                when 0 => data_out <= data_t(LDI_C);
                when 1 => data_out <= data_t(0);
                when 2 => data_out <= data_t(STR_C);
                when 3 => data_out <= data_t(OUTCR_C);
                when 4 => data_out <= data_t(OUTH_C);
                when 5 => data_out <= data_t(OUTL_C);
                when 6 => data_out <= data_t(IN_C);
                when 7 => data_out <= data_t(CMP_C);
                when 8 => data_out <= data_t(LDR_C);
                when 9 => data_out <= data_t(JZ_C);
                when 10 => data_out <= data_t(17);
                when 11 => data_out <= data_t(JC_C);
                when 12 => data_out <= data_t(16);
                when 13 => data_out <= data_t(DEC_C);
                when 14 => data_out <= data_t(JMP_C);
                when 15 => data_out <= data_t(17);
                when 16 => data_out <= data_t(INC_C);
                when 17 => data_out <= data_t(WAIT_C);
                when 18 => data_out <= data_t(200);
                when 19 => data_out <= data_t(JMP_C);
                when 20 => data_out <= data_t(2);
            end case;
        end if;
    end process mem_cycle;
end impl;
