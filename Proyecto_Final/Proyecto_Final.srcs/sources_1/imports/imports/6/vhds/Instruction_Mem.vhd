library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_Mem is
  Port ( 
        Instruction_Mem_addr: in std_logic_vector(31 downto 0);
        Instruction_Mem_out: out std_logic_vector(31 downto 0)
        );
end Instruction_Mem;

architecture Behavioral of Instruction_Mem is

begin

decode:process(Instruction_Mem_addr)
begin
case Instruction_Mem_addr is
    when "00000000000000000000000000000000" => Instruction_Mem_out <= x"20100001"; 
    when "00000000000000000000000000000100" => Instruction_Mem_out <= x"2011000F"; 
    when "00000000000000000000000000001000" => Instruction_Mem_out <= x"20120010"; 
    when "00000000000000000000000000001100" => Instruction_Mem_out <= x"8C130050"; 
    when "00000000000000000000000000010000" => Instruction_Mem_out <= x"02714024";   
    when "00000000000000000000000000010100" => Instruction_Mem_out <= x"AC080054"; 
    when "00000000000000000000000000011000" => Instruction_Mem_out <= x"0272482A";
    when "00000000000000000000000000011100" => Instruction_Mem_out <= x"1130FFFB";
    when "00000000000000000000000000100000" => Instruction_Mem_out <= x"AC120054";
    when "00000000000000000000000000100100" => Instruction_Mem_out <= x"08000003"; 
    when others  => Instruction_Mem_out <= x"00000000"; 
  end case;
end process;
       
end Behavioral;
