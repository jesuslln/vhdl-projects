library ieee;
use ieee.std_logic_1164.all;

entity Practica9 is
port(
		reset_n : in std_logic;
		p1 : in std_logic;
		p0 : in std_logic;
		s_v : out std_logic;
		s_r : out std_logic);
		
end Practica9;

architecture behavioural of Practica9 is
	
	signal entradas : std_logic_vector(1 downto 0);
	signal clk 			  : std_logic;
	
component DetectorSecuencia
	port(
			reset_n : in std_logic;
			clk : in std_logic;
			p1 : in std_logic;
			p0 : in std_logic;
			s_v : out std_logic;
			s_r : out std_logic);
				
end component;

component DetectorFlanco
	port (
		 e : in std_logic ; -- Entrada
		 reset_n : in std_logic ; -- Inicialización
		 clk : in std_logic ; -- Reloj del sistema
		 s : out std_logic );
				
end component;
	
begin --empieza la chicha

i_DetectorFlanco1: DetectorFlanco
	port map(
				e => not p1,
				reset_n => reset_n,
				clk => clk,
				s => entradas(1));

i_DetectorFlanco2 : DetectorFlanco
	port map(
				e => not p0,
				reset_n => reset_n,
				clk => clk,
				s => entradas(0));

 i_DetectorFlanco3 : DetectorSecuencia
	port map(
		reset_n => reset_n,
		clk => clk,
		p1 => entradas(1),
		p0 => entradas(0),
		s_v => s_v,
		s_r => s_r);

	
end behavioural;