library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
  port (
    Opcode  : in  std_logic_vector(5 downto 0);
    Funct   : in  std_logic_vector(5 downto 0);
    RegWrite 
      : out std_logic;
    ALUControl : out std_logic_vector(2 downto 0)
  );
end control;

architecture rtl of control is
begin
  CONTROL_PROC: process(Opcode, Funct) is
  begin
    case Opcode is
      when "000000" =>
        case Funct is
          when "100000" => -- add
            ALUControl  <= "010";
            RegWrite    <= '1'; 
          when "100010" => -- sub 
            ALUControl  <= "110";
            RegWrite    <= '1'; 
          when others => 
            RegWrite <= '0';
        end case;
      when others =>
        RegWrite <= '0';
    end case;
  end process;
end architecture;
