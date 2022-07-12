library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
  port (
    MAX10_CLK1_50 : in std_logic;
    KEY : in std_logic_vector(1 downto 0);
    -- CLK, RST : in std_logic;
    HEX0, HEX1, HEX2, HEX3 : out std_logic_vector(7 downto 0)
  );
end processador;

architecture rtl of processador is

  component datapath is
    port (
      -- Entrada vindas da controladora
      CLK, RST, 
      MemtoReg, MemWrite, Branch, ALUSrc,
      RegDst, RegWrite
        : in  std_logic;
      ALUControl : in std_logic_vector(2 downto 0);

      -- Saidas para a controladora
      Opcode, Funct : out std_logic_vector(5 downto 0);

      -- Conexão com memória de instruções
      Instr_in  : in std_logic_vector(31 downto 0);
      PC_out    : out std_logic_vector(31 downto 0);

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
      ReadData    : out std_logic_vector(31 downto 0);
      hex0, hex1, hex2, hex3 : out std_logic_vector(7 downto 0)
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

  signal Instr, PC, AddressData, WriteData, ReadData
    : std_logic_vector(31 downto 0);
  signal Opcode, Funct : std_logic_vector(5 downto 0);
  signal 
    MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite
    : std_logic;
  signal ALUControl : std_logic_vector(2 downto 0);

  signal CLK, RST : std_logic;
begin
  RST <= KEY(0);
  CLK <= KEY(1);
  ------------------------------------------------------------------------------
  Caminho_de_Dados: datapath port map (
    CLK, RST,
    MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite,
    ALUControl,
    Opcode, Funct,
    Instr, PC,
    ReadData, AddressData, WriteData
  );
  InstructionMemory: instruction_memory port map (
    PC(7 downto 0), Instr 
  );
  DataMemory: data_memory port map (
    AddressData(7 downto 0), WriteData, MemWrite, CLK, ReadData,
    HEX0, HEX1, HEX2, HEX3
  );
  Controlador: control port map (
    Opcode, Funct, 
    MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite,
    ALUControl
  );
end architecture;