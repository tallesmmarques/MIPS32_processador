library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
  port (
    A, B  : in  std_logic_vector;
    S     : out std_logic_vector
  );
end somador;

architecture rtl of somador is
begin
  S <= std_logic_vector(unsigned(A) + unsigned(B));
end architecture;