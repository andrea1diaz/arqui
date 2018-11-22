module DataMemory (input clk, input rst, input [31:0] addr, input memWrite,
   input memRead, input memToReg,
  input [31:0] writeData, output reg [31:0] out);
    
reg [31:0] memory[0:512];

mux_32 Mux(out, addr);

initial begin
    integer i;
    for(i = 0;i < 512;i = i + 1)
        memory[i] = 32'h00000000;
end

always@ (addr or clk)
    begin
      if(MemRead) begin
        out = memory[addr[9:2]];
      end
    end

always @(negedge clk)
    begin
        if (memWrite) begin
            memory[addr[9:2]] <= writeData;
            out <= writeData;
        end
    end
endmodule
