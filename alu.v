module alu(in1, in2, sel0, sel1, sel2, sel3, sel4, sel5, out);
    input    [31:0] in1;
    input    [31:0] in2;
    input           sel0;
    input           sel1;
    input           sel2;
    input           sel3;
    input           sel4;
    input           sel5;
    output   [31:0] out;
    wire     [31:0] alu_logical_out;
    wire     [31:0] alu_arith_out;

    alu_logical ALU_LOG(in1, in2, sel0, sel1, sel2, alu_logical_out);
    alu_arith ALU_ARIT(in1, in2, sel0, sel1, sel2, sel3, sel4, alu_arith_out);

    mux_32 MUX_TOP(sel5, alu_logical_out, alu_arith_out, out);
endmodule
