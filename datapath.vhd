library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
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
  component somador is
    port (
      A, B  : in  std_logic_vector;
      S     : out std_logic_vector
    );
  end component; 
  component alu is
    port (
      A, B  : in  std_logic_vector(31 downto 0);
      SEL   : in  std_logic_vector(2 downto 0);
      ZF    : out std_logic;
      S     : out std_logic_vector(31 downto 0)
    );
  end component;
  component program_counter is
    port(
      CLOCK : in	std_logic;
      RESET : in std_logic;
      PCl : in std_logic_vector(31 downto 0);
      PC : out std_logic_vector(31 downto 0) := x"00000000"
    );
  end component;
  component mux is
    port (
      DATA1    : in std_logic_vector;
      DATA2    : in std_logic_vector;
      SEL      : in std_logic;
      DATA_OUT : out std_logic_vector
    );
  end component;
  component sign_extend is
    port (
      in16  :  in std_logic_vector(15 downto 0);
      out32 : out std_logic_vector(31 downto 0 )
    );
  end component;

  signal Instr, Result, SrcA, SrcB, RD2, ALUResult, SignImm
    : std_logic_vector(31 downto 0);
  signal PC, PCl
    : std_logic_vector(31 downto 0);
  signal WriteReg
    : std_logic_vector(4 downto 0);
begin
  PC_out <= PC;
  Instr <= Instr_in;
  ------------------------------------------------------------------------------
  PCRegister: program_counter port map (
    CLK, RST, PCl, PC );
  PCPlus4: somador port map (
    PC, x"04", PCl );
  MuxReg: mux port map (
    Instr(20 downto 16), Instr(15 downto 11), RegDst, WriteReg );
  RegisterFile: register_file port map (
    CLK, WE3,
    Instr(25 downto 21),
    Instr(20 downto 16),
    WriteReg,
    Result, SrcA, RD2
  );
  SignExtend: sign_extend port map (
    Instr(15 downto 0), SignImm );
  MuxALUSrc: mux port map (
    RD2, SignImm, ALUSrc, SrcB );
  MainALU: alu port map (
    SrcA, SrcB, ALUControl, ZERO, ALUResult );
  MuxResult: mux port map (
    ALUResult, ReadData, MemtoReg, Result );

  AddressData <= ALUResult;
  Opcode <= Instr(31 downto 26);
  Funct <= Instr(5 downto 0);
end architecture;