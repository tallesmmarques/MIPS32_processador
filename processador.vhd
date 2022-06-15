library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
  port (
    CLK, RST : in std_logic
  );
end processador;

architecture rtl of processador is

  component datapath is
    port (
      CLK, WE3, RST
        : in  std_logic;
      ZERO
        : out std_logic;
      Opcode, Funct : out std_logic_vector(5 downto 0);
      ALUControl : std_logic_vector(2 downto 0)
    );
  end component;

  component control is
    port (
      Opcode  : in  std_logic_vector(5 downto 0);
      Funct   : in  std_logic_vector(5 downto 0);
      RegWrite 
        : out std_logic;
      ALUControl : out std_logic_vector(2 downto 0)
    );
  end component;

  signal Opcode, Funct : std_logic_vector(5 downto 0);
  signal RegWrite, ZERO
    : std_logic;
  signal ALUControl : std_logic_vector(2 downto 0);
begin
  Caminho_de_Dados: datapath port map (
    CLK, RegWrite, RST, ZERO, Opcode, Funct, ALUControl
  );
  Controlador: control port map (
    Opcode, Funct, RegWrite, ALUControl
  );
end architecture;