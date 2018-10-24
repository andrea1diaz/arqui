library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1_5bit is
  Port (
        Mux_in1 : in std_logic_vector(4 downto 0);
        Mux_in2 : in std_logic_vector(4 downto 0);
        Mux_sel: in std_logic;
        Mux_out : out std_logic_vector(4 downto 0));
end Mux2to1_5bit;

architecture Behavioral of Mux2to1_5bit is

begin

multiplx: process(Mux_in1, Mux_in2, Mux_sel)
begin
    case Mux_sel is
        when '0' => Mux_out <= Mux_in1;
        when '1' => Mux_out <= Mux_in2;
        when others => NULL;
    end case;
end process;
end Behavioral;
