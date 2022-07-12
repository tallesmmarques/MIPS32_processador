library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
  port (
    Address     : in  std_logic_vector(7 downto 0);
    WriteData   : in std_logic_vector(31 downto 0);
    WE          : in std_logic;
    CLK         : in std_logic;
    ReadData    : out std_logic_vector(31 downto 0)
  );
end data_memory;

architecture rtl of data_memory is
  type ram_type is array (0 to 2**8-1)  -- 2^8 = 256 campos de 8bits = 64 campos de 32bits
    of std_logic_vector(7 downto 0);   -- guarda até 64 linhas de dados
  signal RAM : ram_type := ( 
    others => (others => '0')
  );

  begin
    ReadData(31 downto 24) <= RAM(to_integer(unsigned(Address)) + 0);
    ReadData(23 downto 16) <= RAM(to_integer(unsigned(Address)) + 1);
    ReadData(15 downto 8)  <= RAM(to_integer(unsigned(Address)) + 2);
    ReadData(7  downto 0)  <= RAM(to_integer(unsigned(Address)) + 3);

    process(CLK, WE) is
      begin
        if(rising_edge(CLK) && WE = '1') then
          RAM(to_integer(unsigned(Address)) + 0) <= WriteDate(31 downto 24);
          RAM(to_integer(unsigned(Address)) + 1) <= WriteDate(23 downto 16);
          RAM(to_integer(unsigned(Address)) + 2) <= WriteDate(15 downto 8);
          RAM(to_integer(unsigned(Address)) + 3) <= WriteDate(7 downto 0);
        end if;
      end process;

end architecture;
