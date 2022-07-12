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
  type ram_type is array (0 to 2**8)  -- 2^8 = 256 campos de 8bits = 64 campos de 32bits
    of std_logic_vector(7 downto 0);   -- guarda até 64 linhas de dados
  signal RAM : ram_type := ( 
    others => (others => '0')
  );
  begin
    process(Address) is
    begin
      -- ReadData(31 downto 24) <= RAM(to_integer(unsigned(Address)) + 0) when isBig='0' else x"00";
      -- ReadData(23 downto 16) <= RAM(to_integer(unsigned(Address)) + 1) when isBig='0' else x"00";
      -- ReadData(15 downto 8)  <= RAM(to_integer(unsigned(Address)) + 2) when isBig='0' else x"00";
      -- ReadData(7  downto 0)  <= RAM(to_integer(unsigned(Address)) + 3) when isBig='0' else x"00";
      if(to_integer(unsigned(Address)) <= 252) then
        ReadData(31 downto 24) <= RAM(to_integer(unsigned(Address)) + 0);
        ReadData(23 downto 16) <= RAM(to_integer(unsigned(Address)) + 1);
        ReadData(15 downto 8)  <= RAM(to_integer(unsigned(Address)) + 2);
        ReadData(7  downto 0)  <= RAM(to_integer(unsigned(Address)) + 3);
      end if;
    end process;

    process(CLK, WE) is
    begin
      if(rising_edge(CLK)) then
        if(WE = '1' and to_integer(unsigned(Address)) <= 252) then
          RAM(to_integer(unsigned(Address)) + 0) <= WriteData(31 downto 24);
          RAM(to_integer(unsigned(Address)) + 1) <= WriteData(23 downto 16);
          RAM(to_integer(unsigned(Address)) + 2) <= WriteData(15 downto 8);
          RAM(to_integer(unsigned(Address)) + 3) <= WriteData(7 downto 0);
        end if;
      end if;
    end process;

end architecture;
