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

#0 intgr= 32'b00000000000000000000010110110000 	;
#1 intgr= 32'b00101100101100110000000001011110  ;
#2 intgr= 32'b00101011111111010001101100011111  ; 
#3 intgr= 32'b00111111010000000000000000000000 	; 
#4 intgr= 32'b01001100010101001110101000001001  ;
#5 intgr= 32'b11101001111111101111011100111010  ;


end

endmodule
