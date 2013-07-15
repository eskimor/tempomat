library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.comp_pack.all;

architecture rot_buf of rot_buf is
begin

  read_value: process(clk_in, rst_in) is
    variable value : natural range 0 to 255;
    variable rot_a_old : std_logic;
    variable rot_b_old : std_logic;
  begin
    if rst_in = '0'
    then
        value := 0;
        value_out <= (others => '0');
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
        rot_a_old := rot_a_i;
        rot_b_old := rot_b_i;
        value_out <= data_t(to_unsigned(value, data_t'length));
    end if;
  end process read_value;

end rot_buf;
