library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_left is
    port (
        DATA_IN  : in std_logic_vector(31 downto 0);
        DATA_OUT : out std_logic_vector(31 downto 0)
    );
end shift_left;

architecture rtl of shift_left is
begin

DATA_OUT(31 downto 2) <= DATA_IN(29 downto 0);
DATA_OUT (1 downto 0) <= "00"; 

end architecture;