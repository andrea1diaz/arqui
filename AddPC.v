module AddPC(A, ADDout, clk);
  output [31:0]ADDout;
  input [31:0]A;
  input clk;
  wire[31:0] temp;

  assign temp = A + 4;
  assign ADDout = temp[31:0];

endmodule
