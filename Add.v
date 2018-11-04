module ADD (A, B, ADDout);
  output [31:0]ADDout;
  input [31:0]A;
  input [31:0]B;

  assign ADDout = A + B;

endmodule
