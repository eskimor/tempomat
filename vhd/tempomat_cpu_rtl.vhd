library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.comp_pack.all;

architecture rtl of tempomat_cpu is

  function hex_to_ascii (constant v : in std_logic_vector ) return data_t is
    variable buf : natural range 0 to 15;
    variable result : natural range 0 to 71;
  begin
    buf := to_integer( unsigned(v) );
    if buf <= 9 then
      result := buf + 48; -- 48 is 0 in ASCII
    else
      buf := buf - 10;
      result := buf + 65; -- 65 is A in ASCII (97 would be a)
    end if;
    return data_t( to_unsigned(result, data_t'length) );
  end function hex_to_ascii;

  function readCommandFromMem(constant addr: in natural ) return commands is
  begin
    case addr is
      when 0 => return LDI_C;
      when 2 => return STR_C;
      when 3 => return OUTCR_C;
      when 4 => return OUTH_C;
      when 5 => return OUTL_C;
      when 6 => return IN_C;
        when 7 => return CMP_C;
        when 8 => return LDR_C;
        when 9 => return JZ_C;
        when 11 => return JC_C;
        when 13 => return DEC_C;
        when 14 => return JMP_C;
        when 16 => return INC_C;
        when 17 => return WAIT_C;
        when 19 => return JMP_C;
        when others =>
          assert false report "No command on this address "&Natural'image(addr) severity failure;
          return JMP_C;
      end case;
    end function readCommandFromMem;
    function readDataFromMem(constant addr: in natural) return natural is
    begin
      case addr is
        when 1 => return 0;
        when 10 =>  return 17;
        when 12 =>  return 16;
        when 15 =>  return 17;
        when 18 => return 200;
        when 20 =>  return 2;
        when others =>
          assert false report "No address on this address "&Natural'image(addr) severity failure;
          return 0;
      end case;
    end function readDataFromMem;

begin

  cpu_cycle: process(rst_in, clk_in) is
    variable addr : natural range 0 to 20;
    variable instr : commands;

    variable accu : natural range 0 to 255;
    variable soll : natural range 0 to 255; -- "Sollwert"
    variable carry : std_logic;
    variable zero : std_logic;

    variable accu_as_data_t : data_t;

    -- wait related:
    variable wait_cnt : natural range 0 to 50000;
    constant ms_time : natural := 50000;

    variable wait_ms_cnt : natural range 0 to 255;
    variable do_wait : std_logic;
  begin
    if rst_in = '0' then
      accu := 0;
      soll := 0;
      addr := 0;
      display_en_out <= '0';
      carry := '0';
      zero := '0';
      -- wait related:
      wait_cnt := 0;
      do_wait := '0';
      wait_ms_cnt := 0;
    elsif clk_in'event and clk_in = '1' then
      if do_wait = '0' then
        display_en_out <= '0'; -- disable, might be overriden depending on command.
        instr := readCommandFromMem(addr);
        report "addr is "&Natural'image( addr )&", instr is "&Integer'image( integer ( commands'pos( instr ) ) );
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
            addr := addr + 1; -- next byte is no instruction, skip it
            accu := readDataFromMem(addr);
          when INC_C => accu := accu + 1;
          when DEC_C => accu := accu -1;
          when STR_C => soll := accu;
          when LDR_C => accu := soll;
          when CMP_C => 
            zero := '0';
            carry := '0';
            if accu = soll then
              zero := '1';
            elsif accu > soll then
              carry := '1';
            end if;
          when JC_C =>
            addr := addr + 1; -- next byte is no instruction, skip it
            if carry = '1' then
              addr := readDataFromMem(addr); -- or even load new address.
              addr := addr - 1;
            end if;
          when JZ_C =>
            addr := addr + 1; -- next byte is no instruction, skip it
            if zero = '1' then
              addr := readDataFromMem(addr); -- or even load new address.
              addr := addr - 1;
            end if;
          when JMP_C =>
            addr := addr + 1; -- next byte is no instruction, skip it
            addr := readDataFromMem(addr); -- load new address
            addr := addr - 1;
          when WAIT_C =>
            do_wait := '1';
            addr := addr + 1; -- drop the wait count
            wait_ms_cnt := readDataFromMem(addr);
        end case;
        addr := addr + 1;
      else -- do_wait = 1 :
        if(wait_ms_cnt > 0) then
          if wait_cnt = ms_time then
            wait_ms_cnt := wait_ms_cnt - 1;
            wait_cnt := 0;
          else
            wait_cnt := wait_cnt + 1;
          end if;
        else
          do_wait := '0'; -- continue ...
        end if;
      end if;
    end if;
  end process cpu_cycle;

end rtl;
