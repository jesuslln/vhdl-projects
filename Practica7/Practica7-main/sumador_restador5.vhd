library ieee;
use ieee.std_logic_1164.all;

entity sumador_restador5 is

	port( a,b : in std_logic_vector (4 downto 0);
		   s : out std_logic_vector (4 downto 0);
			s_r : in std_logic;
			ov : out std_logic);
	 
end sumador_restador5;


architecture structural of sumador_restador5 is

component sumador1bit

	port( a_i, b_i : in std_logic;
				  c_i : in std_logic;
				  s_i : out std_logic;
			c_i_mas_1 : out std_logic);
			
end component;

signal c : std_logic_vector (4 downto 0);
signal b_aux : std_logic_vector (4 downto 0);

	begin 
	
	c(0) <= '0';  
	
	
	GenSum : for i in 0 to 3 generate
			b_aux(i)<= b(i) xor s_r; -- segun el valor de s_r ['0' (b) y '1' (b invertido)]
	
			i_suma : sumador1bit 
				port map( 
				a_i => a(i),
				b_i => b_aux(i),
				c_i => c(i),
				s_i => s(i),
				c_i_mas_1 => c(i+1));
				
	end generate GenSum;
	
	ov <= c(4) and s_r; -- acarreo cuando no está invertido
	
end structural;