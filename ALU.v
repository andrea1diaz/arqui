module ALU (A, B, zero, ALUresult, ALUcontrol);
  output zero;
  output [31:0]ALUresult;
  input [31:0]A;
  input [31:0]B;
  input [2:0] ALUcontrol;

  assign zero = (ALUresult == 0);

  @always @ (A or B or ALUcontrol) begin

  end
