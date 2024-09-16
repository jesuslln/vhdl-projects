library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ControlAparcamiento is
    port(
        clk         : in std_logic;
        reset_n     : in std_logic;
        entra_coche : in std_logic;
        sale_coche  : in std_logic;
        max_coches  : in std_logic_vector(7 downto 0);
        libre       : out std_logic;
        ocupado     : out std_logic;
        num_coches  : out std_logic_vector(7 downto 0)
    );
end ControlAparcamiento;

architecture behavioral of ControlAparcamiento is

    signal contador : unsigned(7 downto 0);
    signal max      : std_logic_vector(7 downto 0);
	 

begin

    
    max      <= max_coches;         -- maximo numero de cohes (señal unsigned)

    process (clk, reset_n)
	 
	 begin
        if reset_n = '0' then 
            contador <= (others => '0');    -- reset contador del Parking a 0
				libre    <= '1';
        else
            if rising_edge(clk) then 	     -- flanco

                if entra_coche = '1' then       -- entra  un coche  
					 
                    if std_logic_vector(contador) < max then      -- Puedo hacer que solo se active cuando sea DISTINTO del max??
                        contador <= contador +1;
                    end if;
					  end if;

                if sale_coche = '1' then       -- sale un coche pueesss restamos, si no tenemos 0 claro
					 
							if std_logic_vector(contador) /= "00000000" then          -- (no queremos deber coches)
                        contador <= contador -1;
							end if;
					end if;

                
                    if std_logic_vector(contador) >= max then     -- Aqui damos valores a los leds (ocupado / libre)
                        ocupado <= '1';
                        libre   <= '0';
                    else
                        ocupado <= '0';
                        libre   <= '1';
                    end if;

            end if;

        end if;
		  
	end process;

        num_coches <= std_logic_vector(contador);
end behavioral;