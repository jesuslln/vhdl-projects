library ieee;
use ieee.std_logic_1164.all;

entity Mux_1 is

	port( b : in std_logic_vector (4 downto 0);
			sel_b : in std_logic;
	      s : out std_logic_vector (4 downto 0));
	 
end Mux_1;

architecture behavioural of Mux_1 is


begin

	s <= b when sel_b = '0' else
		"00001" when sel_b = '1' else
		"-----";
					
end behavioural;