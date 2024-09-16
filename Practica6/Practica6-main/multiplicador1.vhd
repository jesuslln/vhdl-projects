library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity multiplicador1 is
	port(
	a_i : in std_logic;
	b_i : in std_logic;
	p_i : out std_logic);
end multiplicador1;

architecture behavioral of multiplicador1 is
begin
	p_i <= a_i and b_i;
end behavioral;
	