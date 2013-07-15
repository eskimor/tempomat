library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    sysclk_i        : in  std_logic;

    -- LCD Interface
    lcd_db_io       : inout std_logic_vector(7 downto 0);
    lcd_rs_o        : out std_logic;
    lcd_en_o        : out std_logic;
    lcd_rw_o        : out std_logic;

    -- Rotary Knob (ROT)
    rot_center_i    : in  std_logic; -- used as reset
    rot_a_i         : in  std_logic;
    rot_b_i         : in  std_logic
  );

end top;
