library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
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
end register_file;

architecture rtl of register_file is
    -- Defining the array of registers and setting all of them to 0
    type file_type is array (0 to 31) of std_logic_vector(31 downto 0);
    signal registers : file_type := (
        others => (others => '0')
    );

begin
    -- Checking if there's something to write
    process(CLK, WE3) is
    begin
        if(rising_edge(CLK) and WE3 = '1') then
            registers(to_integer(unsigned(A3))) <= WD3;
        end if;
	 
	 -- Forcing $0 to be 0 again
    registers(0) <= x"00000000";
    end process;
    
    -- Register data output
    RD1 <= registers(to_integer(unsigned(A1)));
    RD2 <= registers(to_integer(unsigned(A2)));
    
end architecture;