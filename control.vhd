library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
    port (
        Opcode     : in  std_logic_vector(5 downto 0);
        Funct      : in std_logic_vector(5 downto 0);  
        MemtoReg   : out std_logic;
        MemWrite   : out std_logic;
        Branch     : out std_logic;
        ALUSrc     : out std_logic;
        RegDst     : out std_logic;
        RegWrite   : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0);
    );
end control;

architecture rtl of control is

component main_control is
    port (
        Opcode     : in  std_logic_vector(5 downto 0);
        MemtoReg   : out std_logic;
        MemWrite   : out std_logic;
        Branch     : out std_logic;
        ALUSrc     : out std_logic;
        RegDst     : out std_logic;
        RegWrite   : out std_logic;
        ALUop      : out std_logic_vector(1 downto 0)
    );
end component;

component alu_control is
    port (
        Funct      : in std_logic_vector(5 downto 0);  
        ALUop      : in std_logic_vector(1 downto 0);
        ALUControl : out std_logic_vector(2 downto 0)
    );
end component;

signal ALUop : std_logic_vector(1 downto 0);

begin

instancia_main_control : main_control port map (Opcode, MemtoReg, MemWrite, Branch, AlUSrc, RegDst, RegWrite, ALUop);
instancia_alu_control  : alu_control port map (Funct, ALUop, ALUControl);

end architecture;