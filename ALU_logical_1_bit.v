// ALU_logical_1_bit
// Bitwise AND, OR, XOR

module alu_logical_1_bit(in1,in2,sel0,sel1,out);
    input    in1;
    input    in2;
    input    sel0;
    input    sel1;
    output   out;
    wire     and_result;
    wire     or_result;
    wire     xor_result;
    wire     mux0_out;

    assign and_result = in1 & in2;
    assign or_result = in1 | in2;
    assign xor_result = in1 ^ in2;

    mux MUX0(sel0, and_result, or_result, mux0_out);
    mux MUX1(sel1, mux0_out, xor_result, out);
endmodule
