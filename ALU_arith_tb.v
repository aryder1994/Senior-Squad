`timescale 1ns/1ps

module ALU_tb;
			reg    [31:0] in1, in2;
			reg    		sel0,sel1,sel2,sel3,sel4;			
			
			wire   [31:0] out;
			wire   adder_out, cout, overflow;
			wire   [31:0] sum,diff, seq_out, sne_out, slt_out, sgt_out, sle_out, sge_out, mux_5_out, mux_0_out, mux_1_out, mux_2_out, mux_3_out, mux_4_out,in2_final;
		
	
	alu_arith alu_0(
			.in1(in1),
			.in2(in2),
			.sel0(sel0),
			.sel1(sel2),
			.sel2(sel2),
			.sel3(sel3),
			.sel4(sel4),
			.out(out),
			.sum(sum),
			.adder_out(adder_out),
			.cout(cout),
			.overflow(overflow),
			.diff(diff),
			.seq_out(seq_out),
			.sne_out(sne_out),
			.slt_out(slt_out),
			.sgt_out(sge_out),
			.sle_out(sle_out),
			.sge_out(sge_out),
			.mux_5_out(mux_5_out),
			.mux_0_out(mux_0_out),
			.mux_1_out(mux_1_out),
			.mux_2_out(mux_2_out),
			.mux_3_out(mux_3_out),
			.mux_4_out(mux_4_out),
			.in2_final(in2_final)
			);			 
			 
			initial
			begin
			$monitor("in1 = %b,in2 = %b,sel0 = %b,sel1 = %b,sel2 = %b,sel3 = %b,sel4 = %b,out = %b, sum = %b,adder_out = %b, cout = %b, overflow = %b, diff = %b, seq_out = %b, sne_out = %b, slt_out = %b, sgt_out = %b, sle_out = %b, sge_out = %b,mux_5_out= %b, mux_0_out = %b, mux_1_out = %b, mux_2_out = %b, mux_3_out = %b, mux_4_out = %b,in2_final = %b",in1, in2, sel0, sel1, sel2, sel3, sel4, out, sum, adder_out, cout, overflow, diff, seq_out, sne_out, slt_out, sgt_out, sle_out, sge_out, mux_5_out, mux_0_out, mux_1_out, mux_2_out, mux_3_out, mux_4_,outin2_final);

			
			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel0=1'b0; sel1=1'b0; sel2=1'b0; sel3=1'b0; sel4=1'b1;//SEQ
			#1 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel0=1'b1; sel1=1'b0; sel2=1'b0; sel3=1'b0; sel4=1'b1;//SNE
			#2 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel0=1'b0; sel1=1'b1; sel2=1'b0; sel3=1'b0; sel4=1'b1;//SLT
			#3 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel0=1'b1; sel1=1'b1; sel2=1'b0; sel3=1'b0; sel4=1'b1;//SGT
			#4 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel0=1'b0; sel1=1'b0; sel2=1'b1; sel3=1'b0; sel4=1'b1;//SLE
			#5 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel0=1'b0; sel1=1'b1; sel2=1'b1; sel3=1'b0; sel4=1'b1;//SGE
			#6 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel0=1'b0; sel1=1'b0; sel2=1'b0; sel3=1'b1; sel4=1'b1;//SUB
			#7 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel0=1'b0; sel1=1'b0; sel2=1'b0; sel3=1'b0; sel4=1'b0;//ADD
			
	end

endmodule
