library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory is
  port (
    Address     : in  std_logic_vector(7 downto 0);
    ReadData    : out std_logic_vector(31 downto 0)
  );
end instruction_memory;

architecture rtl of instruction_memory is
  type rom_type is array (0 to 2**8-1)  -- 2^8 = 256 campos de 8bits = 64 campos de 32bits
    of std_logic_vector(7 downto 0);   -- guarda até 64 linhas instruções
  signal ROM : rom_type := ( 
    -- Codigo simples
    -- x"02", x"32", x"80", x"20", -- add $s0 $s1, $s2
    -- x"02", x"50", x"98", x"20", -- add $s3 $s2 $s0
    -- x"02", x"12", x"A0", x"22", -- sub $s4 $s0 $s2

    -- Soma dos n primeiros números inteiros
    x"20", x"08", x"00", x"00",  -- addi $t0, $0, 0
    x"20", x"09", x"00", x"0a",  -- addi $t1, $0, 10
    x"00", x"00", x"80", x"20",  -- add  $s0, $0, $0
    x"00", x"00", x"88", x"20",  -- add  $s1, $0, $0
    x"AC", x"09", x"00", x"FC",  -- sw
    x"11", x"09", x"00", x"05",  -- for: beq $t0, $t1, final
    x"21", x"08", x"00", x"01",  -- addi $t0, $t0, 1
    x"02", x"08", x"80", x"20",  -- add  $s0, $s0, $t0
    x"02", x"28", x"88", x"22",  -- sub  $s1, $s1, $t0
    x"10", x"00", x"ff", x"fb",  -- beq  $0, $0, for
    x"AC", x"10", x"FF", x"FC",  -- sw   $s0, 0xFFFC($0)
                                 -- final

    others => (others => '0')
  );

  signal isBig : std_logic;
begin
  isBig <= '1' when to_integer(unsigned(Address)) > 252 else '0';

  ReadData(31 downto 24) <= ROM(to_integer(unsigned(Address)) + 0) when isBig='0' else x"00";
  ReadData(23 downto 16) <= ROM(to_integer(unsigned(Address)) + 1) when isBig='0' else x"00";
  ReadData(15 downto 8)  <= ROM(to_integer(unsigned(Address)) + 2) when isBig='0' else x"00";
  ReadData(7  downto 0)  <= ROM(to_integer(unsigned(Address)) + 3) when isBig='0' else x"00";
end architecture;
