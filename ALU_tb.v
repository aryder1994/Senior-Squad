`timescale 1ns/1ps

module ALU_tb;
			reg    [31:0] in1,in2;
			reg           sel0,sel1;
			wire   [31:0] out;
	
	alu_logical_32 alu_logical_1_bit ALU_LOGICAL_N(
			.in1(in1),
			.in2(in2),
			.sel0(sel0),
			.sel1(sel1),
			.out(out));
			 
			initial
			begin
			$monitor("in1 = %b,in2 = %b,sel0 = %b,sel1 = %b,out = %b",in1, in2, sel0, sel1, out);

			#0 in1= 32'b00000000000000000000000000000000; in2= 32'b00000000000000000000000000000000; sel0= 1'b0; sel1= 1'b0;
			#1 in1= 32'b00000000000000000000000000000000; in2= 32'b00000000000000000000000000000000; sel0= 1'b0; sel1= 1'b0;
			#2 in1= 32'b00000000000000000000000000000000; in2= 32'b00000000000000000000000000000000; sel0= 1'b0; sel1= 1'b0;
			#3 in1= 32'b00000000000000000000000000000000; in2= 32'b00000000000000000000000000000000; sel0= 1'b0; sel1= 1'b0;


	end

endmodule