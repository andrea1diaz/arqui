library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS_Top is
port(
    clk_top : in std_logic;
    reset_top : in std_logic;
    switches: in std_logic_vector(7 downto 0);
    leds: out std_logic_vector(4 downto 0)
    );
end MIPS_Top;

architecture Behavioral of MIPS_Top is

component Pcounter is
port(
    pc_clk : in std_logic;
    PC_reset : in std_logic;
    PC_in : in std_logic_vector(31 downto 0);
    PC_out : out std_logic_vector(31 downto 0)
    );
end component;

component Instruction_Mem is
port(
    Instruction_mem_addr : in std_logic_vector(31 downto 0);
    Instruction_mem_out: out std_logic_vector(31 downto 0)
    );
end component;

component Add is
port(
    Add_in1 : in std_logic_vector(31 downto 0);
    Add_in2 : in std_logic_vector(31 downto 0);
	Add_out : out std_logic_vector(31 downto 0)
    );
end component;

component Mux2to1_32bit is
port(
    Mux_in1 : in std_logic_vector(31 downto 0);
    Mux_in2 : in std_logic_vector(31 downto 0);
    Mux_sel: in std_logic;
    Mux_out : out std_logic_vector(31 downto 0)
    );
end component;

component Register_MEM is
port(
    clk : in std_logic;
    reset: in std_logic;
    RegWrite: in std_logic;
	reg1_read : in std_logic_vector(4 downto 0);
	reg2_read: in std_logic_vector(4 downto 0);
	register_mem_write : in std_logic_vector(4 downto 0);
	WB: in std_logic_vector(31 downto 0);
	data1_read:out std_logic_vector(31 downto 0);
	data2_read:out std_logic_vector(31 downto 0)
    );
end component;

component Mux2to1_5bit is
port(
    Mux_in1 : in std_logic_vector(4 downto 0);
    Mux_in2 : in std_logic_vector(4 downto 0);
    Mux_sel: in std_logic;
    Mux_out : out std_logic_vector(4 downto 0)
    );
end component;

component Sign_extend is
port(
    sign_extend_in: in std_logic_vector(15 downto 0);
    sign_extend_out: out std_logic_vector(31 downto 0)
    );
end component;

component ALUControl is
port(
    ALUOp : in std_logic_vector(1 downto 0);
	FuncCode : in std_logic_vector(5 downto 0);
	ALUCtl : out std_logic_vector(3 downto 0)
    );
end component;

component ALU is
port(
    A : in std_logic_vector(31 downto 0);
	B : in std_logic_vector(31 downto 0);
	AlUCtl : in std_logic_vector(3 downto 0);
	ALUOut : out std_logic_vector(31 downto 0);
	Zero : out std_logic
    );
end component;

component ShiftLeft2 is
port(
    ShiftLeft_in : in std_logic_vector(31 downto 0);
	ShiftLeft_out : out std_logic_vector(31 downto 0)
    );
end component;

component Data_Memory_VHDL is
port(
    clk: in std_logic;
    reset: in std_logic;
    mem_access_addr: in std_logic_Vector(31 downto 0);
    mem_write_data: in std_logic_Vector(31 downto 0);
    mem_write_en : in std_logic_vector(0 downto 0);
    mem_read:in std_logic;
    mem_read_data: out std_logic_Vector(31 downto 0)
    );
end component;

component Control is
port(
    clk : in std_logic;
    reset : in std_logic;
    Opcode : in std_logic_vector(5 downto 0);
    RegWrite : out std_logic;
    RegDst : out std_logic;
    ALUSrc : out std_logic;
    ALUOp : out std_logic_vector(1 downto 0);
    Branch : out std_logic;
    Jump : out std_logic;
    MemRead : out std_logic;
    MemWrite : out std_logic_vector(0 downto 0);
    MemtoReg : out std_logic
    );
end component;

component LWDECODER
port(
		MemRead: in std_logic;
		WB: in std_logic_vector(31 downto 0);
		Regcomp : in std_logic_vector(31 downto 0);
		switches_in : in std_logic_vector(31 downto 0);
		lwdecodeout : out std_logic_vector(31 downto 0)
	);
end component;

component SWDECODER
port(
		MemWrite: in std_logic_vector(0 downto 0);
		Regand : in std_logic_vector(31 downto 0);
		WR : in std_logic_vector(31 downto 0);
		swdecodeout : out std_logic_vector(31 downto 0)
	);
end component;

signal sig_PC : std_logic_vector(31 downto 0);

signal const_4 : std_logic_vector(31 downto 0) := "00000000000000000000000000000100";
signal sig0_PC_mux1 : std_logic_vector(31 downto 0);
signal sig1_PC_mux1 : std_logic_vector(31 downto 0);

signal instr32bit : std_logic_vector(31 downto 0);
signal sig_PCjump : std_logic_vector(31 downto 0);
signal concatenate : std_logic_vector(31 downto 0);
signal sig1_PC_mux2 : std_logic_vector(31 downto 0);

signal sigout_RegDst : std_logic_vector(4 downto 0);
signal sigout_MemtoReg : std_logic_vector(31 downto 0);

signal ALU_in1 : std_logic_vector(31 downto 0);
signal sig0_ALUSrc : std_logic_vector(31 downto 0);
signal sig1_ALUSrc : std_logic_vector(31 downto 0);
signal sigout_ALUSrc : std_logic_vector(31 downto 0);
signal ALU_in2 : std_logic_vector(31 downto 0);

signal sig_ALUCont : std_logic_vector(3 downto 0);
signal sig_ALUOut : std_logic_vector(31 downto 0);
signal zero_flag : std_logic;

signal sig_branch_add : std_logic_vector(31 downto 0);
signal branchtaken : std_logic;
signal sig0_PC_mux2 : std_logic_vector(31 downto 0);

signal sig1_MemtoReg : std_logic_vector(31 downto 0);

signal PC_out : std_logic_vector(31 downto 0);

signal RegWrite_i : std_logic;
signal RegDst_i : std_logic;
signal ALUSrc_i : std_logic;
signal ALUOp_i : std_logic_vector(1 downto 0);
signal Branch_i : std_logic;
signal Jump_i : std_logic;
signal MemRead_i : std_logic;
signal MemWrite_i : std_logic_vector(0 downto 0);
signal MemtoReg_i : std_logic;

signal sig_WB: std_logic_vector(31 downto 0);
signal sig_switches_extended: std_logic_vector(31 downto 0);
signal sig_swdecodeout: std_logic_vector(31 downto 0);
signal sig_lwdecodeout: std_logic_vector(31 downto 0);

begin

MIPSControl : Control port map(
    clk => clk_top,
    reset => reset_top,
    Opcode => instr32bit(31 downto 26),
    RegWrite => RegWrite_i,
    RegDst => RegDst_i,
    ALUSrc => ALUSrc_i,
    ALUOp => ALUOp_i,
    Branch => Branch_i,
    Jump => Jump_i,
    MemRead => MemRead_i,
    MemWrite => MemWrite_i,
    MemtoReg => MemtoReg_i
    );

PC : PCounter port map(
    pc_clk => clk_top,
    PC_reset => reset_top,
    PC_in => PC_out,
    PC_out => sig_PC
    );

PCsum4 : Add port map(
        Add_in1 => sig_PC,
        Add_in2 => const_4,
        Add_out => sig0_PC_mux1
        );

InstrMem : Instruction_Mem port map(
        Instruction_mem_addr => sig_PC,
        Instruction_mem_out => instr32bit
        );

sig_PCjump <= "000000" & instr32bit(25 downto 0);

PCjump : ShiftLeft2 port map(
        ShiftLeft_in => sig_PCjump,
        ShiftLeft_out => concatenate
        );

sig1_Pc_mux2 <= sig0_Pc_mux1(31 downto 28) & concatenate(27 downto 0);

mux_RegDst : Mux2to1_5bit port map(
        Mux_in1 => instr32bit(20 downto 16),
        Mux_in2 => instr32bit(15 downto 11),
        Mux_sel => RegDst_i,
        Mux_out => sigout_RegDst
        );

SignExtend : Sign_extend port map(
        sign_extend_in => instr32bit(15 downto 0),
        sign_extend_out => sig1_ALUSrc
        );

RegMem : Register_MEM port map(
        RegWrite => RegWrite_i,
        reset => reset_top,
        clk => clk_top,
	    reg1_read => instr32bit(25 downto 21),
	    reg2_read => instr32bit(20 downto 16),
	    register_mem_write => sigout_RegDst,
	    WB => sig_lwdecodeout,
	    data1_read => ALU_in1,
	    data2_read => sig0_ALUSrc
	    );

mux_ALUSrc : mux2to1_32bit port map(
        Mux_in1 => sig0_ALUSrc,
        Mux_in2 => sig1_ALUSrc,
        Mux_sel => ALUSrc_i,
        Mux_out => ALU_in2
        );

ALUCont : ALUControl port map(
        ALUOp => ALUOp_i,
	    FuncCode => instr32bit(5 downto 0),
	    ALUCtl => sig_ALUCont
	    );

MIPSALU : ALU port map(
        A => ALU_in1,
        B => ALU_in2,
        AlUCtl => sig_ALUCont,
        ALUOut => sig_ALUOut,
        Zero => zero_flag
        );

Branchjump : ShiftLeft2 port map(
        ShiftLeft_in => sig1_ALUSrc,
        ShiftLeft_out => sig_branch_add
        );

Branchadd : Add port map(
        Add_in1 => sig0_PC_mux1,
        Add_in2 => sig_branch_add,
        Add_out => sig1_PC_mux1
        );

branchtaken <= zero_flag and Branch_i;

PCMux1 : Mux2to1_32bit port map(
        Mux_in1 => sig0_PC_mux1,
        Mux_in2 => sig1_PC_mux1,
        Mux_sel => branchtaken,
        Mux_out => sig0_PC_mux2
        );

PCmux2 : Mux2to1_32bit port map(
        Mux_in1 => sig0_PC_mux2,
        Mux_in2 => sig1_PC_mux2,
        Mux_sel => Jump_i,
        Mux_out => PC_out
        );

DataMem : Data_Memory_VHDL port map(
    clk => clk_top,
    reset => reset_top,
    mem_access_addr => sig_ALUOut,
    mem_read => MemRead_i,
    mem_write_en => MemWrite_i,
    mem_write_data => sig0_ALUSrc,
    mem_read_data => sig1_MemtoReg
    );

muxMemtoReg : Mux2to1_32bit port map(
        Mux_in1 => sig_ALUOut,
        Mux_in2 => sig1_MemtoReg,
        Mux_sel => MemtoReg_i,
        Mux_out => sigout_MemtoReg
        );

-- Decodificador de SW (activar leds)
        
swDecode: SWDECODER port map( MemWrite => MemWrite_i,
                              Regand => sig_ALUOut,
                              WR => sig0_ALUSrc,
                              swdecodeout => sig_swdecodeout);
        
leds <= sig_swdecodeout(4 downto 0);
        
        
-- Decodificador de LW (leer switches)
        
    
        
sig_switches_extended <=  x"000000" & switches;
        
        
lwDecode: LWDECODER port map( MemRead => MemRead_i,
                              Regcomp => sig_ALUOut,
                              WB => sigout_MemtoReg,
                              switches_in => sig_switches_extended,
                              lwdecodeout => sig_lwdecodeout);

end Behavioral;
