// 1-bit Full Adder in Verilog

module adder(x,y,z,sum,c);
input x,y,z;
output sum,c;
wire sum,c;

assign sum=x^y^z;
assign c=((x&y) | (y&z) | (x&z));

endmodule