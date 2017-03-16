// ALU_logical_32_bit
// Bitwise AND, OR, XOR

module
alu_logical_32(in1,in2,sel0,sel1,out);
    input    [31:0] in1;
    input    [31:0] in2;
    input           sel0;
    input           sel1;
    output   [31:0] out;

    genvar i;
    generate
    for (i=0; i<32; i=i+1)
    begin: gen_loop
        alu_logical_1_bit ALU_LOGICAL_N(in1[i], in2[i], sel0, sel1, out[i]);
    end
    endgenerate
endmodule
