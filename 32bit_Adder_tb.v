`timescale 1ns/1ps

module 32bit_Adder_tb;
reg	[31:0] a,b;
reg cin;
wire [31:0] sum;
wire [30:0] c;
wire cout;


adder ADDER0 (
		.a(a),
		.b (b),
		.cin(cin),
		.sum(sum),
		.c(c),
		.cout(cout));


initial
begin

$monitor("a = %b,b = %b,cin = %b,sum = %b,c = %b,cout = %b",a, b, cin,sum,cout,c)

#0 a= 32'b00000000000000000000000000000000; b= 32'b00000000000000000000000000000000; cin= 1'b0;
#1 a= 32'b00000000000000000000000000000011; b= 32'b00000000000000000000000001010010; cin= 1'b1;
#2 a= 32'b11111111111111111111111111111111; b= 32'b11111111111111111111111111111111; cin= 1'b0;
#3 a= 32'b01100011101011100110101010101111 ; b= 32'00001001101011100111110011110010 ; cin= 1'b1;


end

endmodule