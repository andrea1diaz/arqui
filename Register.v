module Register(clk, rst, readReg1, readReg2,
  writeReg,
  RegWrite, MemtoReg, MemWrite, Branch, ALUsrc, inmediate);
  //TODO writeBack

reg clk, rst;
reg RegWrite, MemtoReg, MemWrite;
reg [4:0] readReg2, readReg1, writeReg;
reg [31:0] readData1, readData2, writeBack;
reg [31:0] reg_file [31:0];

reg [31:0] B;

mux_32 Mux(readData2, extended, B);

alu ALU(clk, rst, readData1, B, RegWrite, MemtoReg, MemWrite, Branch);

integer i;
initial begin
for( i = 0; i < 32; i = i + 1 )
    register_file[ i ] = 32'h00000001;
end
always@(posedge clk, rst, writeBack, regMemWrite, writeRegBool)
begin
	if(rst)
		integer i;
		for(i = 0;i < 32;i = i +1)
			reg_file[i] = 32'h00000000;
	if(regWrite)
		reg_file[writeReg] = writeBack;
end

always@(posedge clk, writeRegBool)
begin
	if(!regWriteBool)
		readData1 = reg_file[readReg1];
		readData2 = reg_file[readReg2];
end
endmodule
