module InstructionMemory (ReadAddress, Instruction, clk);
  output [31:0]Instruction;
  input [31:0]ReadAddress;
  input clk;

  always @ ( ReadAddress ) begin


  end

endmodule // InstructionMemory
