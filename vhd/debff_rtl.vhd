
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;
use work.comp_pack.all;

architecture rtl of debff is

  signal flipflops   : std_logic_vector(1 downto 0); --input flip flops
  signal counter_set : std_logic;                    --sync reset to zero
  signal counter_out : std_logic_vector(CNTR_SIZE downto 0) := (others => '0'); --counter output  (19 bits gives 10.5ms with 50MHz clock)
begin
counter_set <= flipflops(0) xor flipflops(1);   --determine when to start/reset counter

process(clk_in)
begin
  if clk_in'event and clk_in = '1' then
    flipflops(0) <= button_in;
    flipflops(1) <= flipflops(0);
    if counter_set = '1' then                  --reset counter because input is changing
      counter_out <= (others => '0');
    elsif counter_out(CNTR_SIZE) = '0' then --stable input time is not yet met
      counter_out <= counter_out + 1;
    else                                        --stable input time is met
      button_out <= flipflops(1);
    end if;
  end if;
end process;

end rtl;
