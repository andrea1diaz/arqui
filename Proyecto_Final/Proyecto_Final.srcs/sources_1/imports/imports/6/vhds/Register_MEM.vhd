library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_MEM is
Port( 
        clk : in std_logic;
        reset: in std_logic;
		RegWrite: in std_logic;
		reg1_read : in std_logic_vector(4 downto 0);
		reg2_read: in std_logic_vector(4 downto 0);
		register_mem_write: in std_logic_vector(4 downto 0);
		WB: in std_logic_vector(31 downto 0);
		data1_read:out std_logic_vector(31 downto 0);
		data2_read:out std_logic_vector(31 downto 0)
	 );
end Register_MEM;

architecture Behavioral of Register_MEM is

type RAM is array (0 to 31) of std_logic_vector(31 downto 0);
signal REGISTERS: RAM;

begin

process(reset, RegWrite, WB, register_mem_write, clk) begin
	if (reset = '1') then
		REGISTERS(0)  <= (others=>'0');--$zero
		
		REGISTERS(1)  <= "00000000000000000000000000000001";--$at
		
		REGISTERS(2)  <= "00000000000000000000000000000010";--$v0
		REGISTERS(3)  <= (others=>'0');--$v1
		
		REGISTERS(4)  <= "00000000000000000000000000000100";--$a0
		REGISTERS(5)  <= (others=>'0');--$a1
		REGISTERS(6)  <= "00000000000000000000000000000110";--$a2
		REGISTERS(7)  <= (others=>'0');--$a3
		
		REGISTERS(8)  <= (others=>'0');--$t0
		REGISTERS(9)  <= (others=>'0');--$t1
		REGISTERS(10)  <= (others=>'0');--$t2
		REGISTERS(11)  <= (others=>'0');--$t3
		REGISTERS(12)  <= (others=>'0');--$t4
		REGISTERS(13)  <= (others=>'0');--$t5
		REGISTERS(14)  <= (others=>'0');--$t6
		REGISTERS(15)  <= (others=>'0');--$t7
		
		REGISTERS(16)  <= (others=>'0');--$s0
		REGISTERS(17)  <= (others=>'0');--$s1
		REGISTERS(18)  <= (others=>'0');--$s2
		REGISTERS(19)  <= (others=>'0');--$s3
		REGISTERS(20)  <= (others=>'0');--$s4
		REGISTERS(21)  <= (others=>'0');--$s5
		REGISTERS(22)  <= (others=>'0');--$s6
		REGISTERS(23)  <= (others=>'0');--$s7
		
		REGISTERS(24)  <= (others=>'0');--$t8
		REGISTERS(25)  <= (others=>'0');--$t9
		
		REGISTERS(26)  <= (others=>'0');--$k0
		REGISTERS(27)  <= (others=>'0');--$k1
		
		REGISTERS(28)  <= (others=>'0');--$gp
		
		REGISTERS(29)  <= (others=>'0');--$sp
		
		REGISTERS(30)  <= (others=>'0');--$fp
		
		REGISTERS(31)  <= (others=>'0');--$ra
		
	elsif (clk'event and clk = '1') then
		if (RegWrite= '1') then
           REGISTERS(to_integer(unsigned(register_mem_write))) <= WB;
        end if;
	end if;
end process;

process(clk, RegWrite)
begin
    if (clk'event and clk = '0') then
        if (RegWrite = '0') then
            data1_read <= REGISTERS(to_integer(unsigned(reg1_read)));
            data2_read <= REGISTERS(to_integer(unsigned(reg2_read)));
        end if;
    end if;
end process;

end Behavioral;