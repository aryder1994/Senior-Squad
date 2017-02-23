`timescale 1ns/1ns


module single_cycle_tb;
	reg clk = 0;
	reg pcSelector = 1;
	reg [31:0] startAddress;
	
	
	single_cycle single_cycle_0(
		.clk(clk),
		.pcSelector(pcSelector),
		.startAddress(startAddress)
		);
		

		
	always #5 clk = ~clk;
	
	
		
		
		//if pcSelector == 1, set startAddress, wait clock cycle, pcSelector = 0
		
initial
begin

		startAddress = 32'b00000000000000000000000000000000;
				
		#11 pcSelector = 0;
		
		
		
			
		
end
endmodule		
	