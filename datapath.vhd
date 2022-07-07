library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
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
  -- component instruction_memory is
  --   port (
  --     Address     : in  std_logic_vector(7 downto 0);
  --     ReadData    : out std_logic_vector(31 downto 0)
  --   );
  -- end component;
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

  signal Instr, Result, SrcA, SrcB, RD2, ALUResult
    : std_logic_vector(31 downto 0);
  signal PC, PCl
    : std_logic_vector(31 downto 0);
begin
  PC_out <= PC;
  Instr <= Instr_in;
  ------------------------------------------------------------------------------
  PCRegister: program_counter port map (
    CLK, RST, PCl, PC );
  PCPlus4: somador port map (
    PC, x"04", PCl );
  -- InstructionMemory: instruction_memory port map (
  --   PC, Instr );
  RegisterFile: register_file port map (
    CLK, WE3,
    Instr(25 downto 21),
    Instr(20 downto 16),
    Instr(15 downto 11),
    Result, SrcA, RD2
  );
  SrcB <= RD2;
  MainALU: alu port map (
    SrcA, SrcB, ALUControl, ZERO, ALUResult
  );
  Result <= ALUResult;

  Opcode <= Instr(31 downto 26);
  Funct <= Instr(5 downto 0);
end architecture;