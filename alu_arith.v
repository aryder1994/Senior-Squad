//ALU
// ADD, SUB, SEQ, SNE, SLT, SGT, SLE, SGE


// Control Signals (ctrlSig)
//      sel0  sel1  sel2  sel3  sel4  
//SEQ   0     0     0     0     1
//SNE   1     0     0     0     1
//SLT   0     1     0	    0     1
//SGT   1     1     0	    0     1
//SLE   X     0     1	    0     1 
//SGE   X     1     1	    0     1
//SUB   X     X     X 	  1     1
//ADD   X     X     X	    X     0





module alu_arith(in1, in2, sel0, sel1, sel2, sel3, sel4, out);
    input    [31:0] in1;
    input    [31:0] in2;
    input           sel0, sel1, sel2, sel3, sel4;
    output   [31:0] out;
    wire     [31:0] add_sub_result;
    wire            is_not_zero;
    wire            a_msb;
    wire            b_msb;
    wire            diff_msb;
    wire            sgt_lsb;
    wire            slt_lsb;
    wire            cout;    
    wire            overflow;
    wire     [31:0] seq_out;
    wire     [31:0] sne_out;
    wire     [31:0] slt_out;
    wire     [31:0] sgt_out;
    wire     [31:0] sle_out;
    wire     [31:0] sge_out;
    wire     [31:0] mux_5_out;
    wire     [31:0] mux_0_out;
    wire     [31:0] mux_1_out;
    wire     [31:0] mux_2_out;
    wire     [31:0] mux_3_out;
    wire     [31:0] mux_4_out;
    wire     [31:0] in2_final;


    mux_32 MUX_in2(sel4, in2, ~in2, in2_final);


    //if ctrlSig[0] is 0, add but if it is 1, subtract
    adder_32 ADDER1 (in1, in2_final, sel4, add_sub_result, cout, overflow);

    or_32_input ZEROCHECK (add_sub_result, is_not_zero);
    assign a_msb = in1[31];
    assign b_msb = in2[31];
    assign diff_msb = add_sub_result[31];
    assign sgt_lsb = sgt_out[0];
    assign slt_lsb = slt_out[0];

    seq SEQ1(is_not_zero, seq_out);
    sne SNE1(is_not_zero, sne_out);
    slt SLT1(a_msb, b_msb, diff_msb, slt_out);
    sgt SGT1(a_msb, b_msb, diff_msb, is_not_zero, sgt_out);
    sle SLE1(sgt_lsb, sle_out);
    sge SGE1(slt_lsb, sge_out);


    mux_32 MUX_32_0(sel0, seq_out, sne_out, mux_0_out);
    mux_32 MUX_32_1(sel0, slt_out, sgt_out, mux_1_out);
    mux_32 MUX_32_2(sel1, mux_0_out, mux_1_out, mux_2_out);
    mux_32 MUX_32_3(sel1, sle_out, sge_out, mux_3_out);
    mux_32 MUX_32_4(sel2, mux_2_out, mux_3_out, mux_4_out);
    mux_32 MUX_32_5(sel3, mux_4_out, add_sub_result, mux_5_out);
    mux_32 MUX_32_6(sel4, add_sub_result, mux_5_out, out);
endmodule
    




