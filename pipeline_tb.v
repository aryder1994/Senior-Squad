`timescale 1ns/1ps

module pipeline_tb;
	reg clk = 0;
	reg pcSelector = 1;
	reg [31:0] startAddress;
	
	wire     [31:0] unshiftedMemDataUnsigned, aluResultMem, busBMem2;
	wire            memWr;
	wire      [1:0] dataSize;
	wire     [31:0] currentAddress, instruction;
	
	
	pipeline pipeline_0(clk, pcSelector, startAddress, unshiftedMemDataUnsigned, instruction, currentAddress, aluResultMem, busBMem2, memWr, dataSize);
	dmem DATA_MEM(aluResultMem, unshiftedMemDataUnsigned, busBMem2, memWr, dataSize, clk);
	imem INST_MEMORY(currentAddress, instruction);

		
	always #5 clk = ~clk;
	
	
		
		
		//if pcSelector == 1, set startAddress, wait clock cycle, pcSelector = 0
		
initial
begin		
		$readmemh("data.hex", DATA_MEM.mem);
		$readmemh("instr.hex", INST_MEMORY.mem);

		startAddress = 32'b00000000000000000000000000000000;
				
		#16 pcSelector = 0;
		
end
endmodule		
	