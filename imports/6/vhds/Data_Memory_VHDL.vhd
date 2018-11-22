library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  
-- VHDL code for the data Memory of the MIPS Processor
entity Data_Memory_VHDL is
port (
 clk: in std_logic;
 reset: in std_logic;
 mem_access_addr: in std_logic_Vector(31 downto 0);
 mem_write_data: in std_logic_Vector(31 downto 0);
 mem_write_en : in std_logic_vector(0 downto 0);
 mem_read: in std_logic;
 mem_read_data: out std_logic_Vector(31 downto 0)
);
end Data_Memory_VHDL;

architecture Behavioral of Data_Memory_VHDL is
signal i: integer;
signal ram_addr: std_logic_vector(4 downto 0);
type data_mem is array (0 to 31) of std_logic_vector (31 downto 0);
signal RAM: data_mem;
begin

 ram_addr <= mem_access_addr(6 downto 2);
 process(clk,reset)
 begin

  if reset = '1' then
	RAM(0) <= x"00000001";
	RAM(1) <= x"00000002";
	RAM(2) <= x"00000003";
	RAM(3) <= x"00000004";
	RAM(4) <= x"00000005";
	RAM(5) <= x"00000006";
	RAM(6) <= x"00000007";
	RAM(7) <= x"00000008";	
	RAM(8) <= x"00000009";
	RAM(9) <= x"0000000A";
	RAM(10) <= x"0000000B";
	RAM(11) <= x"0000000C";
	RAM(12) <= x"0000000D";
	RAM(13) <= x"0000000E";
	RAM(14) <= x"0000000F";
	RAM(15) <= x"00000010";
	RAM(16) <= x"00000011";
    RAM(17) <= x"00000012";
    RAM(18) <= x"00000013";
    RAM(19) <= x"00000014";
    RAM(20) <= x"00000015";
    RAM(21) <= x"00000016";
    RAM(22) <= x"00000017";
    RAM(23) <= x"00000018";    
    RAM(24) <= x"00000019";
    RAM(25) <= x"0000001A";
    RAM(26) <= x"0000001B";
    RAM(27) <= x"0000001C";
    RAM(28) <= x"0000001D";
    RAM(29) <= x"0000001E";
    RAM(30) <= x"0000001F";
    RAM(31) <= x"00000020";    
    
        
  elsif(rising_edge(clk)) then
  if (mem_write_en="1") then
  ram(to_integer(unsigned(ram_addr))) <= mem_write_data;
  end if;
  end if;
 end process;

 read: process (ram_addr, mem_read,RAM)
 begin
if mem_read = '1' then
 mem_read_data <= ram(to_integer(unsigned(ram_addr)));
else
mem_read_data <= x"00000000";
end if;
end process;
end Behavioral;
