`timescale 1ns/1ps

module Signed_Mult_tb;
	reg	[31:0] in1,in2;
	reg 	clk = 0;
	reg  start;
	wire	[63:0] out;
	

	multiplier mult_0(
		.clk(clk),
		.start(start),
		.in1(in1),
		.in2(in2),
		.out(out)
		);

always #5 clk = ~clk;

initial
begin

	$monitor("in1 = %b,in2 = %b,out = %b", in1, in2, out);


#5 in1= 3; in2=4; start=1;


#50 in1= $random; in2=$random;


end

endmodule
