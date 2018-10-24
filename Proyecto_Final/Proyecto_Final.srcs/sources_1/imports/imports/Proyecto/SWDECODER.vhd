library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SWDECODER is
port(
		MemWrite: in std_logic_vector(0 downto 0);
		Regand : in std_logic_vector(31 downto 0);
		WR : in std_logic_vector(31 downto 0);
		swdecodeout : out std_logic_vector(31 downto 0)
	);
end SWDECODER;

architecture Behavioral of SWDECODER is

begin

decode: process(MemWrite, Regand, WR)
begin

if MemWrite = "1" and Regand = x"00000054" then
	swdecodeout <= WR;
else
	swdecodeout <= x"00000000";
end if;
end process;
end Behavioral;
