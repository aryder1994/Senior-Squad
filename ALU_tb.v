`timescale 1ns/1ps

module ALU_tb;
			reg    [31:0] in1,in2;
			reg           sel0,sel1,sel2;
			wire   [31:0] out,logical_32_out,sll_out,srl_sra_out,mux_0_out;
		
	
	alu_logical_32 alu_logical(
			.in1(in1),
			.in2(in2),
			.sel0(sel0),
			.sel1(sel1),
			.out(out),
			.logical_32_out(logical_32_out),
			.sll_out(sll_out),
			.srl_sra_out(srl_sra_out),
			.mux_0_out(mux_0_out)			
			);
			 
			initial
			begin
			$monitor("in1 = %b,in2 = %b,sel0 = %b,sel1 = %b,out = %b,logical_32_out = %b,sll_out = %b,srl_sra_out = %b, mux_0_out = %b"
			,in1, in2, sel0, sel1, out, logical_32_out, sll_out, srl_sra_out, mux_0_out);

			#0 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel2= 1'b0; sel1= 1'b0; sel0= 1'b0; //AND
			#1 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000001; sel2= 1'b0; sel1= 1'b0; sel0= 1'b1; //OR
			#2 in1= 32'b00000000000000000000000000000001; in2= 32'b00000000000000000000000000000000; sel2= 1'b0; sel1= 1'b1; sel0= 1'b0; //XOR
			#3 in1= 32'b00000000000000000000000000110000; in2= 32'b00000000000000000000000000000000; sel2= 1'b1; sel1= 1'b1; sel0= 1'b0; //SLL
			#4 in1= 32'b00000000000000000000000000001111; in2= 32'b00000000000000000000000000000000; sel2= 1'b1; sel1= 1'b0; sel0= 1'b0; //SRA
			#5 in1= 32'b00000000000000000000000000001010; in2= 32'b00000000000000000000000000000000; sel2= 1'b1; sel1= 1'b0; sel0= 1'b1; //SRL
			
	end

endmodule