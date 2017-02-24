//SET Operations

//SEQ

module seq(is_not_zero, out);
    input is_not_zero;
    output [31:0] out;
    assign out[0] = !is_not_zero;
    assign out[31:1] = 31'b0000000000000000000000000000000;
endmodule


//SNE

module sne(is_not_zero, out);
    input is_not_zero;
    output [31:0] out;
    assign out[0] = is_not_zero;
    assign out[31:1] = 31'b0000000000000000000000000000000;
endmodule


//SLT

module slt(a_msb, b_msb, diff_msb, out);
    input a_msb, b_msb, diff_msb;
    output [31:0] out;
    
    assign out[0] = ((a_msb ^ b_msb) & a_msb) | (!(a_msb ^ b_msb) & diff_msb);
    assign out[31:1] = 31'b0000000000000000000000000000000;
endmodule


//SGT

module sgt(a_msb, b_msb, diff_msb, is_not_zero, out);
    input a_msb, b_msb, diff_msb, is_not_zero;
    output [31:0] out;
	
	  assign out[0] = ((a_msb ^ b_msb) & b_msb) | (!(a_msb ^ b_msb) & !diff_msb & is_not_zero);
    assign out[31:1] = 31'b0000000000000000000000000000000;
endmodule


//SLE

module sle(sgt, out);
	input  sgt;
	output [31:0] out;
    
    assign out[0] = !sgt;
    assign out[31:1] = 31'b0000000000000000000000000000000;
endmodule


//SGE

module sge(slt, out);
    input slt;
    output [31:0] out;
    
    assign out[0] = !slt;
    assign out[31:1] = 31'b0000000000000000000000000000000;
endmodule


