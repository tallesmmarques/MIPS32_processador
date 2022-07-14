library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- use std.textio.all;
-- use std.env.finish;

entity tb_processador is
end tb_processador;

architecture sim of tb_processador is
  component processador is
    port (
      CLK, RST : in std_logic
    );
  end component;

  constant clk_hz : integer := 100e6;
  constant clk_period : time := 1 sec / clk_hz;

  signal clk : std_logic := '1';
  signal rst : std_logic := '1';

begin

  clk <= not clk after clk_period / 2;

  DUT : processador port map (clk, rst);

  SEQUENCER_PROC : process
  begin
    wait for clk_period * 2;

    rst <= '0';

    wait for clk_period * 100;

    -- finish;
  end process;

end architecture;