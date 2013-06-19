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
    if clk_in'event then
      addr := to_integer ( unsigned(addr_in) );
      case addr is
        when 0 => data_out <= data_t( to_unsigned(commands'pos(LDI_C), data_t'length) );
        when 1 => data_out <= data_t( to_unsigned(0, data_t'length) );
        when 2 => data_out <= data_t( to_unsigned(commands'pos(STR_C), data_t'length) );
        when 3 => data_out <= data_t( to_unsigned(commands'pos(OUTCR_C), data_t'length) );
        when 4 => data_out <= data_t( to_unsigned(commands'pos(OUTH_C), data_t'length) );
        when 5 => data_out <= data_t( to_unsigned(commands'pos(OUTL_C), data_t'length) );
        when 6 => data_out <= data_t( to_unsigned(commands'pos(IN_C), data_t'length) );
        when 7 => data_out <= data_t( to_unsigned(commands'pos(CMP_C), data_t'length) );
        when 8 => data_out <= data_t( to_unsigned(commands'pos(LDR_C), data_t'length) );
        when 9 => data_out <= data_t( to_unsigned(commands'pos(JZ_C), data_t'length) );
        when 10 => data_out <= data_t( to_unsigned(17, data_t'length));
        when 11 => data_out <= data_t( to_unsigned(commands'pos(JC_C), data_t'length) );
        when 12 => data_out <= data_t( to_unsigned(16, data_t'length));
        when 13 => data_out <= data_t( to_unsigned(commands'pos(DEC_C), data_t'length) );
        when 14 => data_out <= data_t( to_unsigned(commands'pos(JMP_C), data_t'length) );
        when 15 => data_out <= data_t( to_unsigned(17, data_t'length));
        when 16 => data_out <= data_t( to_unsigned(commands'pos(INC_C), data_t'length) );
        when 17 => data_out <= data_t( to_unsigned(commands'pos(WAIT_C), data_t'length) );
        when 18 => data_out <= data_t( to_unsigned(200, data_t'length));
        when 19 => data_out <= data_t( to_unsigned(commands'pos(JMP_C), data_t'length) );
        when 20 => data_out <= data_t( to_unsigned(2, data_t'length));
      end case;
    end if;
  end process mem_cycle;
end tempomat_commands;
