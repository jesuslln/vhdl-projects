library ieee; --tendrá acarreo, cuando se complete un ciclo de 9, se sumara acarreo
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador10 is

		port (
				enable : in std_logic;
				carga : in std_logic;
				e_p : in std_logic_vector(3 downto 0);
				clk : in std_logic;
				reset_n : in std_logic;
				cuenta : out std_logic_vector (3 downto 0);
				co_baja : out std_logic);
				
end Contador10;

architecture behavioural of Contador10 is

signal contador : unsigned(3 downto 0);

begin
contador <= unsigned(e_p);


Conta : process(reset_n, clk)
begin
		if reset_n ='0' then
			contador<= (others =>'0');
		
		else rising_edge(clk) then
		
			if carga ='0' then   --actua como reset sincrono
			contador <= (others => '0');
		
			elsif carga='1' and enable ='0' then 
			contador <= contador - 1;
			
			elsif carga = '1' and enable = '1' then 
			contador <= 9; -- cuando carga sea uno y enable (ha pasado un segundo) sea 1, se reinicia a 9
			
			end if;
			
		end if;
		
	end process;
	
co_baja <= '1' when contador = 0 and enable= '1' else '0';
cuenta <= std_logic_vector(contador);

end behavioural;