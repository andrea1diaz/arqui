module InstructionMemory (Instruction, clk);
  output [31:0]Instruction;
  input clk;

  wire RegDst;
  wire Jump;
  wire Branch;
  wire MemRead;
  wire MemtoReg;
  reg [1:0]ALUOp;
  wire [0:0]MemWrite;
  wire ALUSrc;
  wire RegWrite;
  wire out;
  wire in;
  wire reset;

  wire [31:0] extended;
  wire aux[4:0];

  reg [4:0] alu_control;

control CONTROL(Instruction, clk, in, out, reset, regDst, Branch, ALUop, MemWrite
  ,ALUSrc, RegWrite);

mux_5 Mux_5(Instruction[25:21], Instruction[20:16],
   aux, RegDst);

regis Register(clk, reset, Instruction[25:21],
  Instruction[20:16], aux,
  RegWrite, MemtoReg, MemWrite, Branch, ALUSrc, extended);

ext SignExtend(Instruction[15:0], extended);

alu ALUcontrol(ALUop, Instruction[31:26], alu_control);

always @ ( clk ) begin

end

always @ ( Instruction ) begin
  if (Instruction[31:26] == 6'b000010) begin
    ShiftLeft2Jump ShiftLeft2Jump(Instruction[25:0]);
  end
end

endmodule // InstructionMemory
