library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
  port (
    in16  :  in std_logic_vector(15 downto 0);
    out32 : out std_logic_vector(31 downto 0 )
  );
end sign_extend;

architecture rtl of sign_extend is
begin
  out32(15 downto 0)  <= in16;
  out32(31 downto 16) <= (others => in16(15));
end architecture;