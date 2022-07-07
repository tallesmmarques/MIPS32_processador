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
      ALUControl : in std_logic_vector(2 downto 0);
      ZERO
        : out std_logic;
      Opcode, Funct : out std_logic_vector(5 downto 0);

      -- Conexão com memória de instruções
      Instr_in  : in std_logic_vector(31 downto 0);
      PC_out    : out std_logic_vector(31 downto 0)
    );
  end component;
  component instruction_memory is
    port (
      Address     : in  std_logic_vector(7 downto 0);
      ReadData    : out std_logic_vector(31 downto 0)
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

  signal Instr, PC
    : std_logic_vector(31 downto 0);
  signal Opcode, Funct : std_logic_vector(5 downto 0);
  signal RegWrite, ZERO
    : std_logic;
  signal ALUControl : std_logic_vector(2 downto 0);
begin
  ------------------------------------------------------------------------------
  Caminho_de_Dados: datapath port map (
    CLK, RegWrite, RST, ALUControl, ZERO, Opcode, Funct, 
    Instr, PC
  );
  InstructionMemory: instruction_memory port map (
    PC(7 downto 0), Instr );
  Controlador: control port map (
    Opcode, Funct, RegWrite, ALUControl
  );
end architecture;