module Add (A, B, ADDout, clk);
  output [31:0]ADDout;
  input [31:0]A;
  input [31:0]B;
  input clk;
  wire[31:0] temp;

  assign temp = A + B;
  assign ADDout = temp[31:0];

endmodule
