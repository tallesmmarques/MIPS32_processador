library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gerenciador is
  port (
    Address     : in  std_logic_vector(7 downto 0);
    WriteData   : in std_logic_vector(31 downto 0);
    WE          : in std_logic;
    CLK         : in std_logic;
    ReadData    : out std_logic_vector(31 downto 0);
    hex0, hex1, hex2, hex3 : out std_logic_vector(7 downto 0)
  );
end gerenciador;

architecture rtl of gerenciador is

  component data_memory is
    port (
      Address     : in  std_logic_vector(7 downto 0);
      WriteData   : in std_logic_vector(31 downto 0);
      WE          : in std_logic;
      CLK         : in std_logic;
      ReadData    : out std_logic_vector(31 downto 0)
    );
  end component;

  component display is
    port (
      value : in integer;
      hex0, hex1, hex2, hex3 : out std_logic_vector(7 downto 0)
    );
  end component;

  signal WEMem, WEDisplay : std_logic := '0';
  signal DisplayValue : integer := 0;

  begin
  Memoria: data_memory port map (Address, WriteData, WEMem, CLK, ReadData);
  DisplayOut: display port map (DisplayValue, hex0, hex1, hex2, hex3);

  process(Address, WE) is
  begin
    if(to_integer(unsigned(Address)) < 248) then  -- 0xF8
      WEMem <= WE;
    elsif(Address = x"FC") then
      WEDisplay <= WE;
    else
      WEMem <= '0';
      WEDisplay <= '0';
    end if;
  end process;

  process(CLK, WEDisplay, WriteData)
  begin
    if(rising_edge(CLK) and WEDisplay = '1') then
      DisplayValue <= to_integer(unsigned(WriteData));
    end if;
  end process;
end architecture;
