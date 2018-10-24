library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Add is
port(
		Add_in1 : in std_logic_vector(31 downto 0);
		Add_in2 : in std_logic_vector(31 downto 0);
		Add_out : out std_logic_vector(31 downto 0)
	);
end Add;

architecture Behavioral of Add is

begin

Add_out <= Add_in1 + Add_in2;

end Behavioral;


