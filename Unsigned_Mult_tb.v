`timescale 1ns/1ps

module Unsigned_Mult_tb;
	reg	[31:0] in1,in2;
	reg 	clk;
	wire	[63:0] out;
	

	umultiplier mult_0(
		.clk(clk),
		.in1(in1),
		.in2(in2),
		.out(out)
		);


initial
begin

	$monitor("in1 = %b,in2 = %b,out = %b", in1, in2, out);


#0 in1= $random; in2=$random;
#1 clk = 0;
#2 clk = 1;
#3 clk = 0;
#4 clk = 1;
#5 clk = 0;
#6 clk = 1;
#7 clk = 0;
#8 clk = 1;
#9 clk = 0;

#11 in1= $random; in2=$random;
#12 clk = 0;
#13 clk = 1;
#14 clk = 0;
#15 clk = 1;
#16 clk = 0;
#17 clk = 1;
#18 clk = 0;
#19 clk = 1;
#20 clk = 0;

#22 in1= $random; in2=$random;
#23 clk = 0;
#24 clk = 1;
#25 clk = 0;
#26 clk = 1;
#27 clk = 0;
#28 clk = 1;
#29 clk = 0;
#30 clk = 1;
#31 clk = 0;

#33 in1= $random; in2=$random;
#34 clk = 0;
#35 clk = 1;
#36 clk = 0;
#37 clk = 1;
#38 clk = 0;
#39 clk = 1;
#40 clk = 0;
#41 clk = 1;
#42 clk = 0;

#44 in1= $random; in2=$random;
#45 clk = 0;
#46 clk = 1;
#47 clk = 0;
#48 clk = 1;
#49 clk = 0;
#50 clk = 1;
#51 clk = 0;
#52 clk = 1;
#53 clk = 0;

#55 in1= $random; in2=$random;
#56 clk = 0;
#57 clk = 1;
#58 clk = 0;
#59 clk = 1;
#60 clk = 0;
#61 clk = 1;
#62 clk = 0;
#63 clk = 1;
#64 clk = 0;

end

endmodule
