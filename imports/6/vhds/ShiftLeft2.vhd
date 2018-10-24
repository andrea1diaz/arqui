library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ShiftLeft2 is
port(
		ShiftLeft_in : in std_logic_vector(31 downto 0);
		ShiftLeft_out : out std_logic_vector(31 downto 0)
	);
end ShiftLeft2;

architecture Behavioral of ShiftLeft2 is
signal sig: unsigned(31 downto 0);

begin

sig <= unsigned(ShiftLeft_in);
ShiftLeft_out <= std_logic_vector(sig sll 2);


end Behavioral;



