library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PCounter is
port(
    PC_clk : in std_logic;
    PC_reset : in std_logic;
    PC_in : in std_logic_vector(31 downto 0);
    PC_out : out std_logic_vector(31 downto 0)
    );
end PCounter;

architecture Behavioral of PCounter is

signal counter : std_logic_vector(1 downto 0) := "00";

begin

process(PC_clk, PC_in, PC_reset, counter)
begin
    if (PC_reset = '1') then
        PC_out <= "00000000000000000000000000000000";
        counter <= "01";
    elsif (PC_clk'event and pc_clk = '1') then
        if (counter = "11") then
            PC_out <= PC_in;
            counter <= "01";
        else
            counter <= counter + 1;           
        end if;
    end if;
end process;

end Behavioral;
