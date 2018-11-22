module Datapath;
  reg clk, rst;
  reg[31:0] start;

  PC PCCounter(clk, rst, start);

  Control CONTROL();
  alu ALU():
  memory DataMemory();
  add Add();
  add_pc AddPC();
  register Register();


  always@(PC)

  begin

  end
endmodule
