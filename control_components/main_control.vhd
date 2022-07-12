library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main_control is
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
end main_control;

architecture rtl of main_control is
begin
  MAIN_CONTROL_PROC: process(Opcode) is
  begin
    case Opcode is
      when "000000" => -- R-type
        MemtoReg <= '0';
        MemWrite <= '0';
        Branch <= '0';
        ALUSrc <= '0';
        RegDst <= '1';
        RegWrite <= '1';
        ALUop <= "10";
      when "001000" => -- ADDi
        MemtoReg <= '0';
        MemWrite <= '0';
        Branch <= '0';
        ALUSrc <= '1';
        RegDst <= '0';
        RegWrite <= '1';
        ALUop <= "00";
      when "000100" => -- BEQ
        MemtoReg <= '0';
        MemWrite <= '0';
        Branch <= '1';
        ALUSrc <= '0';
        RegDst <= '0';
        RegWrite <= '0';
        ALUop <= "01";
      when "100011" => -- LW
        MemtoReg <= '1';
        MemWrite <= '0';
        Branch <= '0';
        ALUSrc <= '1';
        RegDst <= '1';
        RegWrite <= '1';
        ALUop <= "00";
      when "101011" => -- SW
        MemtoReg <= '0';
        MemWrite <= '1';
        Branch <= '0';
        ALUSrc <= '1';
        RegDst <= '0';
        RegWrite <= '0';
        ALUop <= "00";
      when others =>
        MemtoReg <= '0';
        MemWrite <= '0';
        Branch <= '0';
        ALUSrc <= '1';
        RegDst <= '0';
        RegWrite <= '0';
        ALUop <= "00";
    end case;
  end process;
end architecture;
