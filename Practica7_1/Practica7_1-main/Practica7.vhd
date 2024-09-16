library ieee;
use ieee.std_logic_1164.all;

entity  Practica7 is
	port(
		a,b : in std_logic_vector(4 downto 0);
		sel : in std_logic_vector(2 downto 0);
		ov : out std_logic;
		s1,s2 : out std_logic_vector(6 downto 0)
		);
end Practica7;


architecture structural of Practica7 is 
signal aux : std_logic_vector(7 downto 0);

component ALU_5bits
		port(
		A,B : in std_logic_vector(4 downto 0);
		sel : in std_logic_vector(2 downto 0);
		OV : out std_logic;
		S : out std_logic_vector(4 downto 0)
		);
end component;

component BinA7Seg
		port(
		input : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(6 downto 0)
		);
end component;


begin

	i_ALU5bits : ALU_5bits
			port map(
			A => a,
			B => b,
			sel => sel,
			OV => ov,
			S => aux(4 downto 0)
			);
			
	aux(6 downto 5) <= (others => '0');
	
	a_BinA7Seg : BinA7Seg
			port map (
			input => aux(3 downto 0),
			output => s1);
			
	b_BinA7Seg : BinA7Seg
			port map (
			input => aux(7 downto 4),
			output => s2);
			
end structural;