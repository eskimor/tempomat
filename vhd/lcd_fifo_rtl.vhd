library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.comp_pack.all;

architecture beh of lcd_fifo is

  type t_memory is array (integer range 0 to 255) of std_logic_vector (0 to 7);

  signal fifo : t_memory := (others => (others => '0'));

  signal s_wp : unsigned (7 downto 0);
  signal s_rp : unsigned (7 downto 0);

  attribute syn_ramstyle : string;
  attribute syn_ramstyle of fifo : signal is "select_ram";
  
begin

  p_fifo_ctrl : process (clk, rst_n)

    variable addr : integer range 0 to 255;
    variable v_wp : unsigned (7 downto 0);
    variable v_rp : unsigned (7 downto 0);

  begin
    if rst_n = '0' then

      dout  <= (others => '0');

--      s_wp  <=(others => '0');
      s_rp  <= (others => '0');

      full  <= '0';
      empty <= '1';

    elsif clk'event and clk = '1' then

      v_rp := s_rp;
      v_wp := s_wp;

      if rd_en = '1' then
	dout <= (others => '0');
	if v_rp /= v_wp then
	  addr := to_integer(v_rp);
	  v_rp := v_rp + "1";
	  dout <= fifo(addr);
	end if;
      end if;

      if wr_en = '1' then
	if v_rp /= v_wp + "1" then
	  addr := to_integer(v_wp);
	  v_wp := v_wp + "1";
	  fifo(addr) <= din;
	end if;
      end if;

      if v_rp = v_wp then
	empty <= '1';
      else
	empty <= '0';
      end if;

      if v_rp = v_wp + "1" then
	full <= '1';
      else
	full <= '0';
      end if;

      s_rp <= v_rp;
      s_wp <= v_wp;

    end if;
  end process p_fifo_ctrl;

end beh;