library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LWDECODER is
port(
		MemRead: in std_logic;
		WB: in std_logic_vector(31 downto 0);
		Regcomp : in std_logic_vector(31 downto 0);
		switches_in : in std_logic_vector(31 downto 0);
		lwdecodeout : out std_logic_vector(31 downto 0)
	);
end LWDECODER;

architecture Behavioral of LWDECODER is

begin

decode: process(MemRead, Regcomp, switches_in,WB)
begin

if MemRead = '1' and Regcomp = x"00000050" then
	lwdecodeout <= switches_in;
else
	lwdecodeout <= WB;
end if;
end process;
end Behavioral;