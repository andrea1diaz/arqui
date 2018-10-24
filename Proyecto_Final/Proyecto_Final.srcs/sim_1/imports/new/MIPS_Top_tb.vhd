----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.07.2018 18:48:06
-- Design Name: 
-- Module Name: MIPS_Top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Top_tb is
--  Port ( );
end MIPS_Top_tb;

architecture Behavioral of MIPS_Top_tb is

component MIPS_Top
port(
    clk_top : in std_logic;
    reset_top : in std_logic;
    switches: in std_logic_vector(7 downto 0);
    leds: out std_logic_vector(4 downto 0);
    sigswitches: out std_logic_vector(31 downto 0);
    sigout_lw : out std_logic_vector(31 downto 0);
    sigout_sw : out std_logic_vector(31 downto 0)
    );
end component;

signal clk_top_tb:std_logic;
signal reset_top_tb : std_logic:='0';
signal switches_tb:std_logic_vector(7 downto 0):=x"00";
signal leds_tb: std_logic_vector(4 downto 0):="00000";
signal sigswitches_tb : std_logic_vector(31 downto 0):=x"00000000";
signal sigout_lw_tb : std_logic_vector(31 downto 0):=x"00000000";
signal sigout_sw_tb : std_logic_vector(31 downto 0):=x"00000000";
signal clk_period:time:=10ns;

begin

uut1: MIPS_top port map( clk_top => clk_top_tb,
                         reset_top => reset_top_tb,
                         switches => switches_tb,
                         leds => leds_tb,
                         sigswitches => sigswitches_tb,
                         sigout_sw => sigout_sw_tb,
                         sigout_lw => sigout_lw_tb);
                         
clockea: process
begin
clk_top_tb <= '0';
wait for clk_period/2;
clk_top_tb <= '1';
wait for clk_period/2;
end process;

simula: process
begin

    wait for 20ns;
        reset_top_tb <= '1';
        switches_tb <= x"00";
    wait for 10ns;
        reset_top_tb <= '0';
        switches_tb <= x"00";
    wait for 10ns;
        reset_top_tb <= '0';
        switches_tb <= x"1F";
    wait;

end process;
end Behavioral;

