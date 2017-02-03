`timescale 1ns/1ps

module ALU_top_tb;
	reg	[31:0] in1,in2;
	reg	sel0,sel1,sel2,sel3,sel4,sel5;
	wire[31:0] out;
	reg[31:0] shift1;
	reg[31:0] shift2;
	reg[31:0] shift3;

	alu alu_0(
		.in1(in1),
		.in2(in2),
		.sel0(sel0),
		.sel1(sel1),
		.sel2(sel2),
		.sel3(sel3),
		.sel4(sel4),
		.sel5(sel5),
		.out(out)
		);


initial
begin

$monitor("in1 = %b,in2 = %b,sel0 = %b,sel1 = %b,sel2 = %b,sel3 = %b,sel4 = %b,sel5 = %b,out = %b", in1, in2, sel0, sel1, sel2, sel3, sel4, sel5, out);

assign shift1[4:0] = $random % 5;
assign shift1[31:5] = 27'b000000000000000000000000000;
assign shift2[4:0] = $random % 5;
assign shift2[31:5] = 27'b000000000000000000000000000;
assign shift3[4:0] = $random % 5;
assign shift3[31:5] = 27'b000000000000000000000000000;

#0  in1= $random; in2= $random; sel0=1'b0; sel1=1'b0; sel2=1'b0; sel3=1'b0; sel4=1'b0; sel5=1'b0; //AND
#1  in1=$random; in2=$random; sel0=1'b1; sel1=1'b0; sel2=1'b0; sel3=1'b0; sel4=1'b0; sel5=1'b0; //OR
#2  in1=$random; in2=$random; sel0=1'b0; sel1=1'b1; sel2=1'b0; sel3=1'b0; sel4=1'b0; sel5=1'b0; //XOR
#3  in1=$random; in2=shift1; sel0=1'b0; sel1=1'b1; sel2=1'b1; sel3=1'b0; sel4=1'b0; sel5=1'b0; //SLL
#4  in1=$random; in2=shift2; sel0=1'b0; sel1=1'b0; sel2=1'b1; sel3=1'b0; sel4=1'b0; sel5=1'b0; //SRA
#5  in1=$random; in2=shift3; sel0=1'b1; sel1=1'b0; sel2=1'b1; sel3=1'b0; sel4=1'b0; sel5=1'b0; //SRL
#6  in1=$random; in2=$random; sel0=1'b0; sel1=1'b0; sel2=1'b0; sel3=1'b0; sel4=1'b1; sel5=1'b1; //SEQ
#7  in1=$random; in2=$random; sel0=1'b1; sel1=1'b0; sel2=1'b0; sel3=1'b0; sel4=1'b1; sel5=1'b1; //SNE
#8  in1=$random; in2=$random; sel0=1'b0; sel1=1'b1; sel2=1'b0; sel3=1'b0; sel4=1'b1; sel5=1'b1; //SLT
#9  in1=$random; in2=$random; sel0=1'b1; sel1=1'b1; sel2=1'b0; sel3=1'b0; sel4=1'b1; sel5=1'b1; //SGT
#10 in1=$random; in2=$random; sel0=1'b0; sel1=1'b0; sel2=1'b1; sel3=1'b0; sel4=1'b1; sel5=1'b1; //SLE
#11 in1=$random; in2=$random; sel0=1'b0; sel1=1'b1; sel2=1'b1; sel3=1'b0; sel4=1'b1; sel5=1'b1; //SGE
#12 in1=$random; in2=$random; sel0=1'b0; sel1=1'b0; sel2=1'b0; sel3=1'b1; sel4=1'b1; sel5=1'b1; //SUB
#13 in1=$random; in2=$random; sel0=1'b0; sel1=1'b0; sel2=1'b0; sel3=1'b0; sel4=1'b0; sel5=1'b1; //ADD
 

end

endmodule