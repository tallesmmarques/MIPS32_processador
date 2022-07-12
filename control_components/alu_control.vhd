library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_control is
  port (
    Funct      : in std_logic_vector(5 downto 0);  
    ALUop      : in std_logic_vector(1 downto 0);
    ALUControl : out std_logic_vector(2 downto 0)
  );
end alu_control;

architecture rtl of alu_control is
begin
  ALU_CONTROL_PROC: process(Funct, ALUop) is
  begin
    case ALUop is
      when "00" => -- sum
        ALUControl <= "010";
      when "01" => -- subtraction
        ALUControl <= "110";
      when "10" | "11" | others => -- look funct
        case Funct is
          when "100000" => -- add
            ALUControl <= "010";
          when "100010" => -- sub
            ALUControl <= "110";
          when "101010" => -- slt
            ALUControl <= "111";
          when "100100" => -- and
            ALUControl <= "000";
          when "100101" => -- or
            ALUControl <= "001";
          when others =>   -- nothing
            ALUControl <= "000";
        end case;
      -- when "11" => -- nothing (look funct)
      --   case Funct is
      --     when "100000" => -- add
      --       ALUControl <= "010";
      --     when "100010" => -- sub
      --       ALUControl <= "110";
      --     when "101010" => -- slt
      --       ALUControl <= "111";
      --     when "100100" => -- and
      --       ALUControl <= "000";
      --     when "100101" => -- or
      --       ALUControl <= "001";
      --   end case;
    end case;
  end process;
end architecture;
