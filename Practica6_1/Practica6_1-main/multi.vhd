library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multi is
	generic(
	n : integer :=4);
	port(
	a : in std_logic_vector(n downto 0);
	b : in std_logic_vector(n downto 0);
	d_0 : out std_logic_vector(6 downto 0);
	d_1 : out std_logic_vector(6 downto 0);
	d_2 : out std_logic_vector(6 downto 0));
end multi;

architecture structural of multi is
	signal pw : std_logic_vector(11 downto 0);
	
	component multiplicador5
	port(
	a : in std_logic_vector(4 downto 0);
	b : in std_logic_vector(4 downto 0);
	p : out std_logic_vector(9 downto 0));
	end component;
	
	component BinA7Seg
	port(
		E			:in std_logic_vector(3 downto 0);
		salida	:out std_logic_vector(6 downto 0));
	end component;
	
begin
Multiplicador5_bits :multiplicador5
	port map(
	p => pw(9 downto 0),
	a=>a,
	b=>b);
	
BinA7Seg_display0 : BinA7Seg
	port map (
	E=> pw(3 downto 0),
	salida => d_0);
BinA7Seg_display1 : BinA7Seg
	port map (
	E=> pw(7 downto 4),
	salida => d_1);
BinA7Seg_display2 : BinA7Seg
	port map(
	E=> "00" & pw(9 downto 8),
	salida =>d_2);
	
end structural;
