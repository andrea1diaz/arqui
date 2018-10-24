library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sign_extend is
  Port (
        sign_extend_in: in std_logic_vector(15 downto 0);
        sign_extend_out: out std_logic_vector(31 downto 0));
end Sign_extend;

architecture Behavioral of Sign_extend is

begin

extend: process (sign_extend_in)
begin
    case sign_extend_in(15) is
        when '0' => sign_extend_out <= "0000000000000000" & sign_extend_in;
        when '1' => sign_extend_out <= "1111111111111111" & sign_extend_in;
        when others => NULL;
    end case;
end process;
end Behavioral;
