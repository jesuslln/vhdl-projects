library ieee;
use ieee.std_logic_1164.all;

entity ALU_5bits is

	port( A,B : in std_logic_vector (4 downto 0);
			sel : in std_logic_vector (2 downto 0);
		   OV : out std_logic;
	      S 	: out std_logic_vector (4 downto 0) );
	 
end ALU_5bits;

architecture structural of Alu_5bits is

signal sel_s : std_logic_vector (1 downto 0);
signal sel_ov : std_logic; 
signal s_r : std_logic;
signal sel_b: std_logic;
signal sel_log: std_logic_vector (1 downto 0);
signal B_1: std_logic_vector (4 downto 0);
signal s1, s2, s3: std_logic_vector (4 downto 0);
signal ov1, ov2: std_logic;

component Mux_1

		port( b : in std_logic_vector(4 downto 0);
				sel_b : in std_logic;
			   s : out std_logic_vector(4 downto 0));
			  
end component;

component Mux_2

		port( a,b 		: in std_logic;
				sel_ov 	: in std_logic;
	         s 			: out std_logic);

end component;

component Mux_3

		port( a,b,c : in std_logic_vector (4 downto 0);
		      sel_s : in std_logic_vector (1 downto 0);
	         s 		: out std_logic_vector (4 downto 0));
					
end component;
		
component Sumador_restador5

		port( a,b : in std_logic_vector (4 downto 0);
		      s : out std_logic_vector (4 downto 0);
			   s_r : in std_logic;
	         ov : out std_logic);

end component;

component FuncionesLogicas

		port( A,B: in std_logic_vector (4 downto 0);
				sel_log : in std_logic_vector (1 downto 0);
	         s : out std_logic_vector (4 downto 0));
		
end component;

component Multiplicador5

		port(
			a,b : in std_logic_vector(4 downto 0);
			p : out std_logic_vector(4 downto 0);
			ov : out std_logic);
		
end component;

component UnidadControl
		port(
		sel : in std_logic_vector(2 downto 0);
		sel_s, sel_log : out std_logic_vector(1 downto 0);
		sel_ov : out std_logic;
		sel_b  : out std_logic;
		s_r    : out std_logic
		);
end component;

signal B2 : std_logic_vector(4 downto 0);


begin


		i_Mux_1 : Mux_1
		 port map(
				b  	=> B,
				sel_b => sel_b,
		      s  	=>  B2 );
				
		i_Sumador : Sumador_restador5
		 port map(
				a  	=> A,
				b  	=> B2,
				s_r   => s_r,
		      s  	=>  s1,
			   ov 	=> ov1	);
				
		i_Mux_2 : Mux_2
		 port map(
				a  		=> ov1,
				b  		=> ov2,
				sel_ov  	=> sel_ov,
		      s  		=>  OV );
				
		i_Logicas : FuncionesLogicas
		 port map(
				A  		=> A,
				B  		=> B,
				sel_log  => sel_log,
		      s  		=>  s3 );
				
		i_Mux_3 : Mux_3
		 port map(
				a  		=> s1,
				b  		=> s2,
				c  		=> s3,
				sel_s   	=> sel_s,
		      s  		=> S );
				
		i_Multiplicador5 : Multiplicador5
		 port map( 
				a 	=> A,
				b 	=> B,
				p 	=> s2,
				ov => ov2);
				
		i_UnidadControl : UnidadControl
			port map (
			sel 		=> sel,
			sel_s 	=> sel_s,
			sel_b 	=> sel_b,
			sel_ov 	=> sel_ov,
			sel_log 	=> sel_log);

end structural;