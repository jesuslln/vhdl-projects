library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplicador5 is
	generic(
	gn : integer := 5);
	port(
	a : in std_logic_vector(gn-1 downto 0);
	b : in std_logic_vector(gn-1 downto 0);
	p : out std_logic_vector(4 downto 0);
	ov : out std_logic);
end multiplicador5;

architecture behavioral of multiplicador5 is
	signal pp0 : unsigned(2*gn-1 downto 0);
	signal pp1 : unsigned(2*gn-1 downto 0);
	signal pp3 : unsigned(2*gn-1 downto 0);
	signal pp2 : unsigned(2*gn-1 downto 0);
	signal pp4 : unsigned(2*gn-1 downto 0);
	signal pp : unsigned(9 downto 0);
begin
	pp0<="00000" &	(a(gn-1) and b(0)) & (a(gn-2) and b(0)) & (a(gn-3) and b(0)) & (a(gn-4) and b(0)) & (a(gn-5) and b(0));		  --ya tenemos 10
	pp1<="0000" & (a(gn-1) and b(1)) & (a(gn-2) and b(1)) & (a(gn-3) and b(1)) & (a(gn-4) and b(1)) & (a(gn-5) and b(1)) & "0";
	pp2<="000" & (a(gn-1) and b(2)) & (a(gn-2) and b(2)) & (a(gn-3) and b(2)) & (a(gn-4) and b(2)) & (a(gn-5) and b(2)) & "00";
	pp3<="00" & (a(gn-1) and b(3)) & (a(gn-2) and b(3)) & (a(gn-3) and b(3)) & (a(gn-4) and b(3)) & (a(gn-5) and b(3)) & "000";
	pp4<="0" & (a(gn-1) and b(4)) & (a(gn-2) and b(4)) & (a(gn-3) and b(4)) & (a(gn-4) and b(4)) & (a(gn-5) and b(4)) & "0000";
	
	pp<= ( pp0 or pp1) or (pp2 or pp3) or pp4;
	p <= std_logic_vector(pp(4 downto 0));
	ov <= '1' when pp(9 downto 5) > 0 else 
	'0';
	
	
end behavioral;