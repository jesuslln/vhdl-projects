library ieee;
use ieee.std_logic_1164.all;

entity sumador1bit is 
	port(
	a_i,b_i : in std_logic;
	c_i : in std_logic;
	s_i : out std_logic;
	c_i_mas_1 : out std_logic);
end sumador1bit;
	
architecture behavioral of sumador1bit is
begin
	s_i <= c_i xor (a_i xor b_i);
	c_i_mas_1 <= (a_i or b_i) or (c_i and (a_i xor b_i));
end behavioral;