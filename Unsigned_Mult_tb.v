`timescale 1ns/1ps

module Unsigned_Mult_tb;
	reg	[31:0] in1,in2;
	reg 	clk;
	wire	[63:0] out;
	

	multiplier mult_0(
		.in1(in1),
		.in2(in2),
		.clk(clk),
		.out(out)
		);


initial
begin

	$monitor("in1 = %b,in2 = %b,out = %b", in1, in2, clk, out);


#0  in1= $random; in2=$random;
#1  in1= $random; in2=$random;
#2  in1= $random; in2=$random;
#3  in1= $random; in2=$random;
#4  in1= $random; in2=$random;
#5  in1= $random; in2=$random;
end

endmodule
