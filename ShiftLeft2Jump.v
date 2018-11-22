module ShiftLeft2Jump (in, out);
  output [25:0]out;
  input [27:0]in;

  assign out = {in[25:0, 2'b0]}

endmodule // ShiftLeft2
