library ieee;
use ieee.numeric_std.all;

package constantes is
  constant naddress : integer;
  constant ndata    : integer;
end package;

package body constantes is
  constant naddress : integer := 8;  -- 8 = 64 instruções
  constant ndata    : integer := 32;
end package body;