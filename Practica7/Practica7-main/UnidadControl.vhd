library ieee;
use ieee.std_logic_1164.all;

entity UnidadControl is
		port(
		sel : in std_logic_vector(2 downto 0);
		sel_s,sel_log : out std_logic_vector(1 downto 0);
		sel_ov : out std_logic;
		sel_b : out std_logic;
		s_r : out std_logic
		);
end UnidadControl;

architecture behavioral of UnidadControl is 

begin

	sel_log <= sel(1 downto 0); 	-- la funcion logica viene definida por los dos bits menos significativos
	
	
	sel_b <= sel(1);				-- el valor de b para la suma depende del bit intermedio
	s_r 	<= sel(0);
	
	with sel select
	sel_s <=
	"11" when "000", -- FL
	"11" when "001",
	"11" when "010",
	"11" when "011",
	"01" when "100", -- S/R
	"01" when "110",
	"01" when "101",
	"10" when "111", -- Ml
	"00" when others;
	
	with sel select
	sel_ov <=
	'0' when "100", -- S/R
	'0' when "110",
	'0' when "101",
	'1' when "111", -- Ml
	'-' when others;
	
end behavioral;