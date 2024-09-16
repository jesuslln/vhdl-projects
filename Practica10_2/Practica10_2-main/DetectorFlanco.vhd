library ieee;
 use ieee. std_logic_1164 .all;

 entity DetectorFlanco is

	 port (
		 e : in std_logic ; -- Entrada
		 reset_n : in std_logic ; -- Inicialización
		 clk : in std_logic ; -- Reloj del sistema
		 s : out std_logic ); -- Salida

 end DetectorFlanco ;

 architecture behavioral of DetectorFlanco is
	 type t_estados is (Esp1 , Pulso , Esp0 ); 	 -- Tipo para los estados
	 signal estado_act , estado_sig : t_estados ; 	 -- Estados actual y siguiente
	 
 begin -- behavioral

 VarEstado : process (clk , reset_n)
	begin
		if reset_n = '0' then 					-- Reset asíncrono
			 estado_act <= Esp1; 				-- (activo bajo)
		else
			if clk'event and clk = '1' then -- Flanco de subida
				estado_act <= estado_sig ;
			end if;
		end if;
end process;

 TransicionEstados : process (estado_act , e)
 begin
	 estado_sig <= estado_act; 	 -- Por defecto nos quedamos en el estado actual
	 
		 case estado_act is
			 when Esp1 =>
				 if e = '1' then
					estado_sig <= Pulso;
				 end if;
			 when Pulso =>
				 if e = '1' then
					estado_sig <= Esp0;
				 else
				 estado_sig <= Esp1;
				 end if;
			 when Esp0 =>
				 if e = '0' then
				 estado_sig <= Esp1;
				 end if;
			 when others => -- Si se salta a un estado raro
				 estado_sig <= Esp1; -- nos vamos al estado inicial
	    end case;
 
 end process TransicionEstados ;

 Salidas : process ( estado_act )
	begin
	 -- Por defecto la salida vale cero
		s <= '0';
	 case estado_act is
		when Esp1 =>
			null;
		when Pulso =>
			s <= '1';
		when Esp0 =>
			null;
		when others =>
			null;
	 end case;
	 
end process Salidas;
end behavioral ;