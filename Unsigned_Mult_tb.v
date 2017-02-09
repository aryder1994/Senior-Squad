`timescale 1ns/1ps

module Unsigned_Mult_tb;
	reg	[31:0] in1,in2;
	wire	[63:0] out;
	

	multiplier mult_0(
		.in1(in1),
		.in2(in2),
		.out(out)
		);


initial
begin

$monitor("in1 = %b,in2 = %b,out = %b", in1, in2, out);


#0  in1= $urandom; in2=$urandom;
#1  in1= $urandom; in2=$urandom;
#2  in1= $urandom; in2=$urandom;
#3  in1= $urandom; in2=$urandom;
#4  in1= $urandom; in2=$urandom;
#5  in1= $urandom; in2=$urandom;
end

endmodule
