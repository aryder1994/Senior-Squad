// ALU_logical
// AND, OR, XOR, SLL, SRA, SRL

// Control Signals
//     sel2   sel1   sel0
// AND    0      0      0
// OR     0      0      1
// XOR    0      1      X
// SLL    1      1      X
// SRA    1      0      0
// SRL    1      0      1

module alu_logical(in1, in2, sel0, sel1, sel2, out);
    input    [31:0] in1;
    input    [31:0] in2;
    input           sel0;
    input           sel1;
    input           sel2;
    output   [31:0] out;
    wire     [31:0] logical_32_out;
    wire     [31:0] sll_out;
    wire     [31:0] srl_sra_out;
    wire     [31:0] mux_0_out;

    alu_logical_32 ALU_logical_32_0(in1, in2, sel0, sel1, logical_32_out);
    sll_32 SLL_32_0(in1, in2, sll_out);
    srl_sra_32 SRL_SRA_32_0(sel0, in1, in2, srl_sra_out);

    mux_32 MUX_32_0(sel1, srl_sra_out, sll_out, mux_0_out);
    mux_32 MUX_32_1(sel2, logical_32_out, mux_0_out, out);
endmodule 
