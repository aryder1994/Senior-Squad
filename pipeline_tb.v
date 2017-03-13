`timescale 1ns/1ps

module pipeline_tb;
	reg clk = 0;
	reg pcSelector = 1;
	reg [31:0] startAddress;
	
	
	pipeline pipeline_0(
		.clk(clk),
		.pcSelect(pcSelector),
		.startAddress(startAddress)
		);
		

		
	always #5 clk = ~clk;
	
	
		
		
		//if pcSelector == 1, set startAddress, wait clock cycle, pcSelector = 0
		
initial
begin

		startAddress = 32'b00000000000000000001000000000000;
				
		#16 pcSelector = 0;
		
		
		
			
		
end
endmodule		
	