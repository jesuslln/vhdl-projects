library ieee;
use ieee.std_logic_1164.all;

entity Mux_2 is

	port( a,b : in std_logic; -- a multiplicador, b sumador
			sel_ov : in std_logic;
	      s : out std_logic );
	 
end Mux_2;

architecture behavioural of Mux_2 is

--signal entrada : std_logic_vector (4 downto 0);

begin

		s <= a when sel_ov = '0' else	-- 0 (sumador) y 1 (multiplicador)
			b when sel_ov = '1' else
			'-';
					
end behavioural;