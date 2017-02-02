//ALU
// ADD, SUB, SEQ, SNE, SLT, SGT, SLE, SGE


// Control Signals (ctrlSig)

//SEQ   0001
//SNE   1001
//SLT   0101
//SGT   0011
//SLE   1101 
//SGE   1011
//ADD   0000





module alu(in1, in2, ctrlSig, out);
    input    [31:0] in1;
    input    [31:0] in2;
    input    [3:0]  ctrlSig;
    output   [31:0] out;
    wire     [31:0] sum;
    wire            adder_out;
    wire            cout;    
    wire            overflow;
    wire     [31:0] diff;    
    wire     [31:0] seq_out;
    wire     [31:0] sne_out;
    wire     [31:0] slt_out;
    wire     [31:0] sgt_out;
    wire     [31:0] sle_out;
    wire     [31:0] sge_out;
    wire     [31:0] logical_32_out;
    wire     [31:0] mux_0_out;
    wire     [31:0] mux_1_out;
    wire     [31:0] mux_2_out;
    wire     [31:0] mux_3_out;
    wire     [31:0] mux_4_out;



    //if ctrlSig[0] is 0, add but if it is 1, subtract
    32_adder ADDER1 (in1, in2, ctrlSig[0], sum, cout, overflow);
    assign diff = sum;

    //double logical negation
    assign adder_out = !(!sum);    //32bit -> 1 bit


    seq SEQ1(adder_out, seq_out);
    sne SNE1(adder_out, sne_out);
    slt SLT1(cout, slt_out);
    sgt SGT1(adder_out, cout, sgt_out);
    sle SLE1(adder_out, cout, sle_out);
    sge SGE1(cout, sge_out);

    alu_logical_32 ALU_LOGICAL_32_0(in1, in2, ctrlSig[1], ctrlSig[2], logical_32_out);

    mux_32 MUX_32_0(sel, seq_out, sne_out, mux_0_out);
    mux_32 MUX_32_1(sel, slt_out, mux_0_out, mux_1_out);
    mux_32 MUX_32_2(sel, sgt_out, mux_1_out, mux_2_out);
    mux_32 MUX_32_3(sel, sle_out, mux_2_out, mux_3_out;
    mux_32 MUX_32_4(sel, sge_out, mux_3_out, mux_4_out);
    mux_32 MUX_32_5(sel, mux_4_out, logical_32_out, out);
    




