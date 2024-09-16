library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador50M is

	port(
				en_cnt : in std_logic;
				clk : in std_logic;
				reset_n : in std_logic;
				salida : out std_logic_vector (26 downto 0);
				co_segundo : out std_logic);
				
end Contador50M;

architecture behavioural of Contador50M is

signal contador : unsigned (26 downto 0);

begin

Conta50 : process (reset_n, clk)
begin

		if reset_n ='0' then
			contador <= (others => '0');
			
		else rising_edge(clk) then
		
			if en_cnt= '0' then 
				contador <= (others => '0');
			elsif en_cnt = '1' and contador/= 50000000 then
				contador <= contador + 1;
			elsif en_cnt = '1' and contador = 50000000 then
				contador <= 0;
			end if;
		end if;
end process;

co_segundo <= '1' when en_cnt ='1' and contador = 50000000 else '0';
salida <= std_logic_vector (contador);

end behavioural;