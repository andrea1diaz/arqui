library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.ALL;

entity ALU is
port( 
        A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		AlUCtl : in std_logic_vector(3 downto 0);
		ALUOut : out std_logic_vector(31 downto 0);
		Zero : out std_logic
	  );
end ALU;

architecture Behavioral of ALU is

signal sum : std_logic_vector(31 downto 0);

begin

process(AlUCtl, A, B) begin

	case AlUCtl is
			--And
			when "0000" => sum <= A and B;
			
			--Or
			when "0001" => sum <= A or B;
			
			--Sum					
			when "0010" => sum <= A + B;
			
			--Sub
			when "0110" => sum <= A - B;
			
			--Slt
			when "0111" => if A(31) = '0' and B(31) = '1' then -- A > B
									sum <= "00000000000000000000000000000000";
								elsif A(31) = '1' and B(31) = '0' then -- A < B
									sum <= "00000000000000000000000000000001";
								else -- (A(31) = '0' and B(31) = '0') or (A(31) = '1' and B(31) = '1')
									if A > B then -- A > B
										sum <= "00000000000000000000000000000000";
									else -- sum(31) = '1' -- A < B
										sum <= "00000000000000000000000000000001";
									end if;
								end if;
								
			when others => sum <= "--------------------------------";
	end case;
end process;

process(sum)
begin
	if sum = "00000000000000000000000000000000" then
		Zero <= '1';
	else
	 Zero <= '0';
	end if;
end process;

ALUOut <= sum;

end Behavioral;
