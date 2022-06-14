library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- library work;
-- use work.datapath_components.all;

entity datapath is
  port (
    CLK, WE3
      : in  std_logic
  );
end datapath;

architecture rtl of datapath is
  component register_file is
    port (
      CLK : in std_logic;
      WE3 : in std_logic;
      A1 : in std_logic_vector(4 downto 0);
      A2 : in std_logic_vector(4 downto 0);
      A3 : in std_logic_vector(4 downto 0);
      WD3 : in std_logic_vector(31 downto 0);

      RD1 : out std_logic_vector(31 downto 0);
      RD2 : out std_logic_vector(31 downto 0)
    );
  end component;
  component instruction_memory is
    port (
      Address     : in  std_logic_vector(7 downto 0);
      ReadData    : out std_logic_vector(31 downto 0)
    );
  end component;
  component somador is
    port (
      A, B  : in  std_logic_vector;
      S     : out std_logic_vector
    );
  end component; 

  signal Instr, Result, SrcA, RD2
    : std_logic_vector(31 downto 0);
  signal PC, PCn
    : std_logic_vector(7 downto 0);
begin
  PCPlus4: somador port map (
    PC, x"04", PCn );
  InstructionMemory: instruction_memory port map (
    PC, Instr );
  RegisterFile: register_file port map (
    CLK, WE3,
    Instr(25 downto 21),
    Instr(20 downto 16),
    Instr(15 downto 11),
    Result, SrcA, RD2
  );
end architecture;