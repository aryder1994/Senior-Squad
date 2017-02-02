`timescale 1ns/1ps

module ALU_tb;
			reg    [31:0] in1, in2;
			reg    [3:0] crtlSig;			
			
			wire   [31:0] out;
			wire   adder_out, cout, overflow;
			wire   [31:0] diff, seq_out, sne_out, slt_out, sgt_out, sle_out, sge_out, logical_32_out, mux_0_out, mux_1_out, mux_2_out, mux_3_out, mux_4_out;
		
	
	alu_logical_32 alu(
			.in1(in1),
			.in2(in2),
			.crtlSig(crtlSig),
			.out(out),
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
			.logical_32_out(logical_32_out),
			.mux_0_out(mux_0_out),
			.mux_1_out(mux_1_out),
			.mux_2_out(mux_2_out),
			.mux_3_out(mux_3_out),
			.mux_4_out(mux_4_out)			
			);			 
			 
			initial
			begin
			$monitor("in1 = %b,in2 = %b,crtlSig = %b,out = %b,adder_out = %b, cout = %b, overflow = %b, diff = %b, seq_out = %b, sne_out = %b, slt_out = %b, sgt_out = %b, sle_out = %b, sge_out = %b,logical_32_out = %b, mux_0_out = %b, mux_1_out = %b, mux_2_out = %b, mux_3_out = %b, mux_4_out = %b",in1, in2, crtlSig, out, adder_out, cout, overflow, diff, seq_out, sne_out, slt_out, sgt_out, sle_out, sge_out, logical_32_out, mux_0_out, mux_1_out, mux_2_out, mux_3_out, mux_4_out);

			
			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; crtlSig= 4'b0001; //SEQ
			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; crtlSig= 4'b1001; //SNE
			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; crtlSig= 4'b0101; //SLT
			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; crtlSig= 4'b0011; //SGT
			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; crtlSig= 4'b1101; //SLE
			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; crtlSig= 4'b1011; //SGE
			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; crtlSig= 4'b0000; //ADD
			
	end

endmodule: