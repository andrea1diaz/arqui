library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
 Port( 
       Opcode : in  STD_LOGIC_VECTOR (5 downto 0);
       clk : in STD_LOGIC;
       reset: in STD_LOGIC;
       RegDst : out  STD_LOGIC;
       MemRead : out  STD_LOGIC;
       MemtoReg : out  STD_LOGIC;
       ALUOp : out  STD_LOGIC_VECTOR (1 downto 0);
       ALUSrc: out STD_LOGIC;
       MemWrite : out  STD_LOGIC_VECTOR (0 downto 0);
       RegWrite : out  STD_LOGIC;
       Jump: out STD_LOGIC;
       Branch: out STD_LOGIC);
end Control;

architecture Behavioral of Control is


type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11);
signal state, next_state : state_type;
-- Internal outputs
--signal Op_i : std_logic_vector(5 downto 0); 
--signal RegDst_i : std_logic;
--signal MemRead_i : std_logic;
--signal MemtoReg_i : std_logic;
--signal ALUOp_i : std_logic_vector(1 downto 0);
--signal ALUSrc_i : std_logic;
--signal MemWrite_i : std_logic_vector(0 downto 0);
--signal RegWrite_i : std_logic;
--signal Jump_i : std_logic;
--signal Branch_i : std_logic;

BEGIN

   SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (reset = '1') then
            state <= S0;
          else
           state <= next_state;
         end if;
      end if;
   end process;

   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
   
      if state = S0 then -- Instruction Fetch
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "00";
        ALUSrc <= '0';
        MemWrite <= "0";
        RegWrite <= '0';
        Branch <= '0';
        Jump <= '0';
      elsif state = S1 then -- LW or SW
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "00";
        ALUSrc <= '1';
        MemWrite <= "0";
        RegWrite <= '0';
        Branch <= '0';
        Jump <= '0';
      elsif state = S2 then -- LW
        RegDst <= '0';
        MemRead <= '1';
        MemtoReg <= '1';
        ALUOp <= "00";
        ALUSrc <= '1';
        MemWrite <= "0";
        RegWrite <= '1';
        Branch <= '0';
        Jump <= '0';
      elsif state = S3 then -- SW
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "00";
        ALUSrc <= '1';
        MemWrite <= "1";
        RegWrite <= '0';
        Branch <= '0';
        Jump <= '0';
      elsif state = S4 then -- Addi
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "00";
        ALUSrc <= '1';
        MemWrite <= "0";
        RegWrite <= '1';
        Branch <= '0';
        Jump <= '0';
      elsif state = S5 then -- R-type
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "10";
        ALUSrc <= '0';
        MemWrite <= "0";
        RegWrite <= '0';
        Branch <= '0';
        Jump <= '0';
      elsif state = S6 then -- R-type
        RegDst <= '1';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "10";
        ALUSrc <= '0';
        MemWrite <= "0";
        RegWrite <= '1';
        Branch <= '0';
        Jump <= '0';
      elsif state = S7 then -- Beq
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "01";
        ALUSrc <= '0';
        MemWrite <= "0";
        RegWrite <= '0';
        Branch <= '0';
        Jump <= '0';
      elsif state = S8 then -- Beq
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "01";
        ALUSrc <= '0';
        MemWrite <= "0";
        RegWrite <= '0';
        Branch <= '1';
        Jump <= '0';
      elsif state = S9 then -- Jump
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "00";
        ALUSrc <= '0';
        MemWrite <= "0";
        RegWrite <= '0';
        Branch <= '0';
        Jump <= '0';
      else -- Jump
        RegDst <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "00";
        ALUSrc <= '0';
        MemWrite <= "0";
        RegWrite <= '0';
        Branch <= '0';
        Jump <= '1';
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, Opcode)
   begin
 
      next_state <= state;  --default is to stay in current state
   
      case (state) is
         when S0 => 
            if (Opcode = "100011" or Opcode = "101011" or Opcode = "001000") then
                next_state <= S1;
            elsif Opcode = "000000" then
                next_state <= S5;
            elsif Opcode = "000100" then
                next_state <= S7;
            elsif Opcode = "000010" then
                next_state <= S9;
            end if;
         when S1 =>
            if Opcode = "100011" then -- LW
                next_state <= S2;
            elsif Opcode = "101011" then -- SW
                next_state <= S3;
            elsif Opcode = "001000" then -- Addi
                next_state <= S4;
            end if;
         when S5 => next_state <= S6;
         when S7 => next_state <= S8;
         when S9 => next_state <= S10;
         when others => next_state <= S0;
      end case;
   end process;
end Behavioral;