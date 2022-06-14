library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (
    A, B  : in  std_logic_vector(31 downto 0);
    SEL   : in  std_logic_vector(2 downto 0);
    ZF    : out std_logic;
    S     : out std_logic_vector(31 downto 0)
  );
end alu;

architecture rtl of alu is
  signal at, bt, st : unsigned(31 downto 0);
begin
  at <= unsigned(A);
  bt <= unsigned(B);
  st <= at and bt when SEL = "000" else
        at or  bt when SEL = "001" else
        at  +  bt when SEL = "010" else
        at  -  bt when SEL = "110" else
        x"00000001" when SEL = "111" and at < bt else
        x"00000000" when SEL = "111" and at >= bt else
        at;

  ZF <= '1' when st = x"00000000" else '0';        
  S  <= std_logic_vector(st);
end architecture;