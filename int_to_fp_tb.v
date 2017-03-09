`timescale 1ns/1ps
`include"int_to_fp.v"

module int_to_fp_tb;
reg	[31:0] intgr;
wire [31:0] fp;


int_to_fp CONV (
		.intgr(intgr),
		.fp(fp));

initial
begin

$monitor("intgr = %b,fp = %b",intgr,fp);

#0 intgr= 32'b00000000000000000000010110110000;
#1 intgr= 32'b11100101010011100011111101110100 ;
#2 intgr= 32'b00110000111010000010100101110100 ; 
#3 intgr= 32'b00111111010000000000000000000000 ; 
#4 intgr= 32'b01111111000000111110100100011001 ;


end

endmodule
