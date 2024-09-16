library ieee;
use ieee.std_logic_1164.all;

entity Sum5B is 
	port(
	a,b : in std_logic_vector(4 downto 0);
	s : out std_logic_vector(4 downto 0);
	c_out : out std_logic);
end Sum5B;


architecture structural of Sum5B is 
signal c : std_logic_vector(5 downto 0);

component Sum1B
	port(
	a_i,b_i : in std_logic;
	c_i : in std_logic;
	s_i : out std_logic;
	c_i_mas_1 : out std_logic
	);
end component;

begin -- structural

	c(0) <= '0';  -- acarreo inicial
	c_out <= c(5); -- acarreo final

	GenSum : for i in 0 to 4 generate
		i_Sum1B : Sum1B
			port map (
				a_i => a(i),
				b_i => b(i),
				c_i => c(i),
				s_i => s(i),
				c_i_mas_1 => c(i+1)
				);
				
	end generate GenSum;

end structural;