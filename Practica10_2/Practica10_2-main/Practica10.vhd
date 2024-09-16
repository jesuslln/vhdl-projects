library ieee;
use ieee.std_logic_1164.all;


entity Practica10 is
    port(
        clk         : in std_logic;
        reset_n     : in std_logic;
        entra_coche : in std_logic;
        sale_coche  : in std_logic;
        max_coches  : in std_logic_vector(7 downto 0);
        libre       : out std_logic;
        ocupado     : out std_logic;
        s1,s2  		: out std_logic_vector(6 downto 0)
		  );
end Practica10;

architecture structural of Practica10 is  

	signal entra, sale : std_logic;
	signal aux 			 : std_logic_vector(7 downto 0);

	component DetectorFlanco
		port (
			e 			: in std_logic ; 
			reset_n 	: in std_logic ; 
			clk 		: in std_logic ; 
			s 			: out std_logic ); 
	
	end component;
	
	
	component ControlAparcamiento
		    port(
        clk         : in std_logic;
        reset_n     : in std_logic;
        entra_coche : in std_logic;
        sale_coche  : in std_logic;
        max_coches  : in std_logic_vector(7 downto 0);
        libre       : out std_logic;
        ocupado     : out std_logic;
        num_coches  : out std_logic_vector(7 downto 0));
	end component;
	
	component BinA7Seg
			port(
		input 	: in std_logic_vector(3 downto 0);
		output 	: out std_logic_vector(6 downto 0));
	end component;
	
	
begin

	DetectorFlanco1 : DetectorFlanco
			port map(
				e 			=> entra_coche,
				reset_n 	=> reset_n,
				clk 		=> clk,
				s 			=> entra);
				
	DetectorFlanco2 : DetectorFlanco
			port map(
				e 			=> sale_coche,
				reset_n 	=> reset_n,
				clk 		=> clk,
				s 			=> sale);
				
	ControlAparcamiento1 : ControlAparcamiento
			port map (
				clk 			=> clk,
				reset_n 		=> reset_n,
				entra_coche => entra,
				sale_coche 	=> sale,
				max_coches 	=> max_coches,
				libre 		=> libre,
				ocupado 		=> ocupado,
				num_coches  => aux);
				
	BinA7Seg1 : BinA7Seg
			port map(
			input 	=> aux(3 downto 0),
			output 	=> s1);
			
	BinA7Seg2 : BinA7Seg
			port map(
			input 	=> aux(7 downto 4),
			output 	=> s2);




end structural;