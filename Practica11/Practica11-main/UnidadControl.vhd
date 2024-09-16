library ieee;
use ieee.std_logic_1164.all;


entity UnidadControl is 
port (
			boton : in std_logic;
			puerta : in std_logic;
			fin_cuenta : in std_logic;
			clk : in std_logic;
			reset_n : in std_logic;
			en_cnt : out std_logic;
			carga_min : out std_logic;
			carga_seg : out std_logic;
			fin : out std_logic;
			horno_on : std_logic;
			abierta : out std_logic);
end UnidadControl;


architecture behavioral of UnidadControl is

type t_estados is (Esp1, Esp2, P_ab, P_cr, Fc);
signal est_act, est_sig : t_estados;

Transicion Estados : process(est_act)

est_act = Esp1;

	case est_act is 
	 when Esp1 =>
		if boton = '0' then 
			est_sig <= Esp2;
		end if;
	 when Esp2 =>
		if boton = '0' then 
			est_sig <= P_cr;
		end if;
	when P_cr =>
		if puerta = '1' then
			est_sig = P_ab;
		end if;
			if fin_cuenta = '1'
			est_sig = Fn;
	when P_ab =>
		if puerta = '0' then
			est_sig = P_cr;
		end if;
	when others =>
	estado_sig = Esp1;
end case;
end process;

VarEstado : process(clk,reset_n)

begin
	if reset_n = '0' then 
		est_act <= Esp1;
		horno_on <= '0';
		en_cnt <= '0';
		abierta <= '0';
		fin <= '0';
		carga_min <= '0';
		carga_seg <='0';
	else 
		if rising_edge(clk) then
			est_act <= est_sig;
		end if;
	end if;
	
end process;

Salidas : process(est_act)

begin 

case est_act is 
	when Esp1 =>
		null;
	when Esp2 =>
		carga_min <= '1';
	when P_cr =>
		carga_seg <= '1';
		horno_on <= '1';
		abierta <= '0';
		en_cnt <= '1';
	when P_ab =>
		horno_on <= '0';
		abierta <= '1';
		en_cnt <= '0';
	when Fc =>
		horno_on <= '0';
		fin <= '1';
		en_cnt <= '0';
		
end case;
end process;

end behavioral;