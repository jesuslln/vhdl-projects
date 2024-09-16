library ieee;
use ieee.std_logic_1164.all;

entity Practica5 is 
	port(
	a,b : in std_logic_vector(4 downto 0);
	S0,S1 : out std_logic_vector(6 downto 0);
	ov : out std_logic);
end Practica5;


architecture structural of Practica5 is 
signal auxiliar : std_logic_vector(7 downto 0);

component Sum5B
	port(
	a,b : in std_logic_vector(4 downto 0);
	s : out std_logic_vector(4 downto 0);
	c_out : out std_logic);
end component;

component BinA7Seg
	port(
	input : in std_logic_vector(3 downto 0);
	output : out std_logic_vector(6 downto 0));
end component;

begin -- structural

	i_Sum5B : Sum5B -- calculamos la suma de los bits
		port map(
		a => a,
		b => b,
		s => auxiliar(4 downto 0),
		c_out => ov);
	
	auxiliar(7 downto 5) <= (others => '0');
	
	i1_BinA7Seg : BinA7Seg -- primer codificador
		port map(
		input => auxiliar(3 downto 0),
		output => S0);
	
	i2_BinA7Seg : BinA7Seg -- segundo codificador
		port map(
		input => auxiliar(7 downto 4),
		output => S1);

end structural;