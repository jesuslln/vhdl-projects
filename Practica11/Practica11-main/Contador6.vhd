library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador6 is

	port(
				enable : in std_logic;
				carga : in std_logic;
				e_p : in std_logic_vector(2 downto 0);
				clk : in std_logic;
				reset_n : in std_logic;
				cuenta : out std_logic_vector (2 downto 0);
				co_baja : out std_logic);
				
end Contador6;

architecture behavioural of Contador6 is

signal contador : unsigned (2 downto 0);

begin

contador <= unsigned (e_p);

Conta6 : process (reset_n, clk)
begin

		if reset_n ='0' then
			contador <= (others => '0');
			
		else rising_edge(clk) then
		
			if carga = '0' then 
				contador <= (others => '0');
			elsif carga = '1' and enable = '1' then
				contador <= 6;
			elsif carga ='1' and enable = '0' then
				contador<= contador - 1;
			end if;
		end if;
end process;

co_baja <= '1' when enable ='1' and contador = 0 else '0';
cuenta <= std_logic_vector (contador);

end behavioural;