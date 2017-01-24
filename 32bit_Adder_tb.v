`timescale 1ns/1ps

module tb_32bit_Adder;
reg	[31:0] a,b;
reg cin;
wire [31:0] sum;
wire cout;
wire overflow;


adder_32 ADDER0 (
		.a(a),
		.b (b),
		.cin(cin),
		.sum(sum),
		.cout(cout),
		.overflow(overflow));

initial
begin

$monitor("a = %b,b = %b,cin = %b,sum = %b,cout = %b,overflow = %b",a, b, cin,sum,cout,overflow);

#0 a= 32'b00000000000000000000000000000000; b= 32'b00000000000000000000000000000000; cin= 1'b0;
#1 a= 32'b00000000000000000000000000000011; b= 32'b00000000000000000000000001010010; cin= 1'b1;
#2 a= 32'b11111111111111111111111111111111; b= 32'b11111111111111111111111111111111; cin= 1'b1;
#3 a= 32'b01111111111111111111111111111111; b= 32'b00000000000000000000000000000001; cin= 1'b0;
#4 a= 32'b01100011101011100110101010101111 ; b= 32'b00001001101011100111110011110010 ; cin= 1'b1;


end

endmodule
