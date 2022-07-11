library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
    port (
        DATA1    : in std_logic_vector;
        DATA2    : in std_logic_vector;
        SEL      : in std_logic;
        DATA_OUT : out std_logic_vector
    );
end mux;

architecture rtl of mux is
begin
   
    with SEL select
        DATA_OUT <= DATA1 when '0',
                    DATA2 when others;

end architecture;