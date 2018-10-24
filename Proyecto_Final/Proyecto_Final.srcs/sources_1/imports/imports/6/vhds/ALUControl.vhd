----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:23:13 04/26/2018 
-- Design Name: 
-- Module Name:    ALUControl - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.ALL;

entity ALUControl is
port(	
        ALUOp : in std_logic_vector(1 downto 0);
		FuncCode : in std_logic_vector(5 downto 0);
		ALUCtl : out std_logic_vector(3 downto 0)
	 );
end ALUControl;

architecture Behavioral of ALUControl is 

begin

process(ALUOp, FuncCode) begin
	if ALUOp = "00" then
		ALUCtl <= "0010";
	elsif ALUOp = "01" then
		ALUCtl <= "0110";
	elsif ALUOp = "10" then
		case FuncCode(3 downto 0) is
			when "0000" => ALUCtl <= "0010";
			when "0010" => ALUCtl <= "0110";
			when "0100" => ALUCtl <= "0000";
			when "0101" => ALUCtl <= "0001";
			when "1010" => ALUCtl <= "0111";
			when others => ALUCtl <= "0000";
		end case;
	else --ALUOp = "11" then
		case FuncCode(3 downto 0) is
			when "0000" => ALUCtl <= "0010";
			when "0010" => ALUCtl <= "0110";
			when "0100" => ALUCtl <= "0000";
			when "0101" => ALUCtl <= "0001";
			when "1010" => ALUCtl <= "0111";
			when others => ALUCtl <= "0110";
		end case;
	end if;
end process;

end Behavioral;

