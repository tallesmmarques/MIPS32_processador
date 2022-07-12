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
      -- Entrada vindas da controladora
      CLK, WE3, RST, MemtoReg, MemWrite, Branch, ALUSrc,
      RegDst, RegWrite
        : in  std_logic;
      ALUControl : in std_logic_vector(2 downto 0);

      -- Saidas para a controladora
      Opcode, Funct : out std_logic_vector(5 downto 0);
      ZERO
        : out std_logic;

      -- Conexão com memória de instruções
      Instr_in  : in std_logic_vector(31 downto 0);
      PC_out    : out std_logic_vector(31 downto 0)

      -- Memoria de dados
      ReadData    : in  std_logic_vector(31 downto 0);
      AddressData : out std_logic_vector(31 downto 0);
      WriteData   : out std_logic_vector(31 downto 0)
    );
  end component;

  component instruction_memory is
    port (
      Address     : in  std_logic_vector(7 downto 0);
      ReadData    : out std_logic_vector(31 downto 0)
    );
  end component;
  component data_memory is
    port (
      Address     : in  std_logic_vector(7 downto 0);
      WriteData   : in std_logic_vector(31 downto 0);
      WE          : in std_logic;
      CLK         : in std_logic;
      ReadData    : out std_logic_vector(31 downto 0)
    );
  end component;

  component control is
    port (
      Opcode     : in  std_logic_vector(5 downto 0);
      Funct      : in std_logic_vector(5 downto 0);  
      MemtoReg   : out std_logic;
      MemWrite   : out std_logic;
      Branch     : out std_logic;
      ALUSrc     : out std_logic;
      RegDst     : out std_logic;
      RegWrite   : out std_logic;
      ALUControl : out std_logic_vector(2 downto 0)
    );
  end component;

  signal Instr, PC, AddressData, WriteData, WriteEnable, 
    Result, ReadData
    : std_logic_vector(31 downto 0);
  signal Opcode, Funct : std_logic_vector(5 downto 0);
  signal RegWrite, ZERO, WE3
    : std_logic;
  signal ALUControl : std_logic_vector(2 downto 0);
begin
  ------------------------------------------------------------------------------
  Caminho_de_Dados: datapath port map (
    CLK, WE3, RST,
    MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite,
    AluControl,
    Opcode, Funct,
    ZERO,
    Instr, PC
    ReadData, AddressData, WriteData
  );
  InstructionMemory: instruction_memory port map (
    PC(7 downto 0), Instr 
  );
  DataMemory: data_memory port map (
    AddressData(7 downto 0), WriteData, WriteEnable, CLK, Result
  );
  -- Controlador: control port map (

  -- );
end architecture;