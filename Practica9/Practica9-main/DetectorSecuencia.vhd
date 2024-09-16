library ieee;
use ieee.std_logic_1164.all;

entity DetectorSecuencia is
port(
		reset_n : in std_logic;
		clk : in std_logic;
		p1 : in std_logic;
		p0 : in std_logic;
		s_v : out std_logic;
		s_r : out std_logic);
		
end DetectorSecuencia;

architecture behavioural of DetectorSecuencia is

	type t_estados is (Reposo, EP0, EP0P1, EP0P1P1, EP0P1P1P0); -- tipo para los estados presentes en la practica
	
	signal estado_act, estado_sig : t_estados; --señales para poder trabajar en process, y son de tipo t_estados porque se les otorgará un estado u otro
	
	signal entradas : std_logic_vector(1 downto 0); --señal con dos entradas que seran las salidas del detector de flanco
	
	signal s_sig_v 	 : std_logic;
	signal s_sig_r 	 : std_logic;
	
	component DetectorFlanco
		port(
				e : in std_logic;
				reset_n : in std_logic;
				clk : in std_logic;
				s : out std_logic );
				
	end component;
	
begin --empieza la chicha

Detector_1 : DetectorFlanco
port map(
			e => p1,
			reset_n => reset_n,
			clk => clk,
			s => entradas(1));

Detector_2 : DetectorFlanco
port map(
			e => p0,
			reset_n => reset_n,
			clk => clk,
			s => entradas(0));

TransEstados : process (estado_act, entradas)
begin
		estado_sig <= estado_act; -- para abarcar todos los casos
		case estado_act is 
		
			when Reposo =>
			
				if entradas = "01" then
					estado_sig <= EP0;
				end if;
			when EP0 =>
			
				if entradas = "10" then
					estado_sig <= EP0P1;
				elsif entradas = "11" then
					estado_sig <= Reposo;
				end if;
				
			when EP0P1 =>
				if entradas = "10" then
					estado_sig <= EP0P1P1;
				elsif entradas = "11" then
					estado_sig <= Reposo;
				elsif entradas = "01" then
					estado_sig <= EP0;
				end if;
				
			when EP0P1P1 =>
				if entradas = "01" then
					estado_sig <= EP0P1P1P0;
				elsif entradas = "11" then
					estado_sig <= Reposo;
				elsif entradas = "10" then
					estado_sig <= Reposo;
				end if;
				
			when EP0P1P1P0 =>
				if entradas = "01" then
					estado_sig <= EP0;
				elsif entradas = "11" then
					estado_sig <= Reposo;
				elsif entradas = "10" then
					estado_sig <= EP0P1;
				end if;
			when others =>
				estado_sig <= Reposo;
		end case;
end process;

VarEstado : process (clk, reset_n)
begin
	if reset_n = '0' then --Reset que prevalece ante todo
		estado_act <= Reposo;
	elsif rising_edge(clk) then
			estado_act <= estado_sig;
	end if;
end process;

s_sig_v <= '1' when estado_act = EP0P1P1P0 else '0';
s_sig_r <= not(s_sig_v);
s_v <= s_sig_v;
s_r <= s_sig_v;

end behavioural;