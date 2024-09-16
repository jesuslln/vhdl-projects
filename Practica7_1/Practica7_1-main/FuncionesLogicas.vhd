library ieee;
use ieee.std_logic_1164.all;

entity FuncionesLogicas is

	port( A,B: in std_logic_vector (4 downto 0);
			sel_log : in std_logic_vector (1 downto 0);
	      S : out std_logic_vector (4 downto 0)); 
	 
end FuncionesLogicas;

architecture behavioural of FuncionesLogicas is


begin
		with sel_log select
		
			S <=  A and B  when "00",
			      A or B when "01",
					A xor B when "10",
					not A when "11",
					"-----" when others;
					
end behavioural;