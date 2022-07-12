library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
  port (
    Address     : in  std_logic_vector(7 downto 0);
    WriteData   : in std_logic_vector(31 downto 0);
    WE          : in std_logic;
    CLK         : in std_logic;
    ReadData    : out std_logic_vector(31 downto 0);
    hex0, hex1, hex2, hex3 : out std_logic_vector(7 downto 0)
  );
end data_memory;

architecture rtl of data_memory is
  type ram_type is array (0 to 2**8-1)  -- 2^8 = 256 campos de 8bits = 64 campos de 32bits
    of std_logic_vector(7 downto 0);   -- guarda até 64 linhas de dados
  signal RAM : ram_type := ( 
    others => (others => '0')
  );
  signal displays : std_logic_vector(31 downto 0) := "00000000";
  signal value, unidade, dezena, centena, milhar : integer;
  begin
    process(Address) is
    begin
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
        elsif(Address = x"FC" and WE = '1') then
          displays <= WriteData;
        end if;
      end if;
    end process;

  value <= to_integer(unsigned(displays));

  unidade <= value mod 10;
  hex0 <= "11000000" when unidade = 0 else
          "11111001" when unidade = 1 else
          "10100100" when unidade = 2 else
          "10110000" when unidade = 3 else
          "10011001" when unidade = 4 else
          "10010010" when unidade = 5 else
          "10000010" when unidade = 6 else
          "11111000" when unidade = 7 else
          "10000000" when unidade = 8 else
          "10010000" when unidade = 9 else
          "11110111" when unidade = 10 else -- A
          "11111100" when unidade = 11 else -- B
          "11111001" when unidade = 12 else -- C
          "11011110" when unidade = 13 else -- D
          "11111001" when unidade = 14 else -- E
          "11110001";

  dezena  <= (value mod 100)/10;
  hex1 <= "11000000" when dezena = 0 else
          "11111001" when dezena = 1 else
          "10100100" when dezena = 2 else
          "10110000" when dezena = 3 else
          "10011001" when dezena = 4 else
          "10010010" when dezena = 5 else
          "10000010" when dezena = 6 else
          "11111000" when dezena = 7 else
          "10000000" when dezena = 8 else
          "10010000" when dezena = 9 else
          "11110111" when dezena = 10 else -- A
          "11111100" when dezena = 11 else -- B
          "11111001" when dezena = 12 else -- C
          "11011110" when dezena = 13 else -- D
          "11111001" when dezena = 14 else -- E
          "11110001";

  centena <= (value mod 1000)/100;
  hex2 <= "11000000" when centena = 0 else
          "11111001" when centena = 1 else
          "10100100" when centena = 2 else
          "10110000" when centena = 3 else
          "10011001" when centena = 4 else
          "10010010" when centena = 5 else
          "10000010" when centena = 6 else
          "11111000" when centena = 7 else
          "10000000" when centena = 8 else
          "10010000" when centena = 9 else
          "11110111" when centena = 10 else -- A
          "11111100" when centena = 11 else -- B
          "11111001" when centena = 12 else -- C
          "11011110" when centena = 13 else -- D
          "11111001" when centena = 14 else -- E
          "11110001";

  milhar  <= (value mod 10000)/1000;
  hex3 <= "11000000" when milhar = 0 else
          "11111001" when milhar = 1 else
          "10100100" when milhar = 2 else
          "10110000" when milhar = 3 else
          "10011001" when milhar = 4 else
          "10010010" when milhar = 5 else
          "10000010" when milhar = 6 else
          "11111000" when milhar = 7 else
          "10000000" when milhar = 8 else
          "10010000" when milhar = 9 else
          "11110111" when milhar = 10 else -- A
          "11111100" when milhar = 11 else -- B
          "11111001" when milhar = 12 else -- C
          "11011110" when milhar = 13 else -- D
          "11111001" when milhar = 14 else -- E
          "11110001";
end architecture;
