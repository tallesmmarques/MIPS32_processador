library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is

	port(
		CLOCK : in	std_logic;
		RESET : in std_logic;
		PC_ : in std_logic_vector(7 downto 0);
		PC : out std_logic_vector(7 downto 0) := x"00";
	);

end entity;

architecture rtl of program_counter is
begin

process(CLOCK, RESET) is
begin
	if(RESET = '1') then
		PC <= x"00";
	elsif(rising_edge(CLOCK)) then
		PC <= PC';
	end if;
end process;
    
end rtl;
