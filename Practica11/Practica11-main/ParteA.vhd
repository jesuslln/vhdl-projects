library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ParteA is

	port(		
			ent: in std_logic_vector (6 downto 0);
			en_cnt : in std_logic;
			clk : in std_logic;
			reset_n : in std_logic;
			c : out std_logic;
			carga_seg : in std_logic;
			carga_min : in std_logic;
			d_d : out std_logic;
			d_c : out std_logic_vector (6 downto 0);
			d_b : out std_logic_vector (6 downto 0);
			d_a : out std_logic_vector (6 downto 0));
				
end ParteA;

architecture structural of Contador50M is

signal co: std_logic_vector (4 downto 0);
signal cnt_seg : std_logic_vector ( 6 downto 0);
signal cnt_min : std_logic_vector ( 6 downto 0);

-- componentes que usaremos posteriormente
component Contador10
		port( 
				enable : in std_logic;
				carga : in std_logic;
				e_p : in std_logic_vector(3 downto 0);
				clk : in std_logic;
				reset_n : in std_logic;
				cuenta : out std_logic_vector (3 downto 0);
				co_baja : out std_logic);
end component;	

component Contador6
		port( 
				enable : in std_logic;
				carga : in std_logic;
				e_p : in std_logic_vector(2 downto 0);
				clk : in std_logic;
				reset_n : in std_logic;
				cuenta : out std_logic_vector (2 downto 0);
				co_baja : out std_logic);
end component;		

component Contador50M
		port( 
				en_cnt : in std_logic;
				clk : in std_logic;
				reset_n : in std_logic;
				salida : out std_logic_vector (26 downto 0);
				co_segundo : out std_logic);
end component;		

component BinA7Seg
		port( 
				input : in std_logic_vector(3 downto 0);
				output : out std_logic_vector(6 downto 0)
	);
		
end component;		
begin

Contador50M_1 : Contador50M

		port map(
				en_cnt => en_cnt,
				clk => clk,
				reset_n => reset_n,
				salida => free ,
				co_segundo => co(0));

Contador10_1 : Contador10

		port map(
				enable => co(0),
				clk => clk,
				carga => carga_seg,
				reset_n => reset_n,
				e_p => ent (3 downto 0),
				cuenta => cnt_seg(3 downto 0) ,
				co_baja => co(1));

Contador6_1 : Contador6

		port map(
				enable => co(1),
				clk => clk,
				carga => carga_seg,
				reset_n => reset_n,
				e_p => ent (6 downto 4),
				cuenta => cnt_seg(6 downto 4),
				co_baja => co(2));

Contador10_2 : Contador10

		port map(
				enable => co(2),
				clk => clk,
				carga => carga_seg,
				reset_n => reset_n,
				e_p => ent (3 downto 0),
				cuenta => cnt_min (3 downto 0) ,
				co_baja => co(3));

Contador6_1 : Contador6

		port map(
				enable => co(3),
				clk => clk,
				carga => carga_seg,
				reset_n => reset_n,
				e_p => ent (6 downto 4),
				cuenta => cnt_min(6 downto 4),
				co_baja => co(4));
				
BinA7Seg_1 : BinA7Seg

		port map(
				input => ('0' & cnt_min(6 downto 4)),
				output=> d_d
		
		);
				
BinA7Seg_2 : BinA7Seg

		port map(
				input => ('0' & cnt_min(3 downto 0)),
				output=> d_c
		
		);
				
BinA7Seg_3 : BinA7Seg

		port map(
				input => ('0' & cnt_seg(6 downto 4)),
				output=> d_b
		
		);
				
BinA7Seg_4 : BinA7Seg

		port map(
				input => ('0' & cnt_seg(3 downto 0)),
				output=> d_a
		
		);
c <= co(4);
end structural;