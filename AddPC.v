module AddPC(A, ADDout, clk);
  output [31:0]ADDout;
  input [31:0]A;
  input clk;
  wire[31:0] temp;

  assign temp = A + 4;
  assign ADDout = temp[31:0];

  always @ ( * ) begin
    if (temp[31:26] == 6'b000010) begin

    end
  end

endmodule
