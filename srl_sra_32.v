// srl_sra_32

module
srl_sra_32(is_logical,a,b,out);
    input           is_logical;
    input    [31:0] a;
    input    [31:0] b;
    output   [31:0] out;
    wire            extend;
    wire     [31:0] shift1;
    wire     [31:0] shift1_result;
    wire     [31:0] shift2;
    wire     [31:0] shift2_result;
    wire     [31:0] shift3;
    wire     [31:0] shift3_result;
    wire     [31:0] shift4;
    wire     [31:0] shift4_result;
    wire     [31:0] shift5;
    wire     [31:0] shift5_result;
    wire     [31:0] pre_or32;
    wire            or32_result;
    wire     [31:0] extend_32;

    mux MUX_1(is_logical, a[31], 1'b0, extend);

    assign shift1[31] = extend;
    assign shift1[30:0] = a[31:1];

    mux_32 MUX_32_1(b[0], a, shift1, shift1_result);

    assign shift2[31] = shift1[31];
    assign shift2[30] = shift1[31];
    assign shift2[29:0] = shift1_result[31:2];

    mux_32 MUX_32_2(b[1], shift1_result, shift2, shift2_result);

    assign shift3[31:30] = shift2[31:30];
    assign shift3[29:28] = shift2[31:30];
    assign shift3[27:0] = shift2_result[31:4];

    mux_32 MUX_32_3(b[2], shift2_result, shift3, shift3_result);

    assign shift4[31:28] = shift3[31:28];
    assign shift4[27:24] = shift3[31:28];
    assign shift4[23:0] = shift3_result[31:8];

    mux_32 MUX_32_4(b[3], shift3_result, shift4, shift4_result);

    assign shift5[31:24] = shift4[31:24];
    assign shift5[23:16] = shift4[31:24];
    assign shift5[15:0] = shift4_result[31:16];

    mux_32 MUX_32_5(b[4], shift4_result, shift5, shift5_result);

    assign pre_or32[4:0] = 5'b00000;
    assign pre_or32[31:5] = b[31:5];

    or_32_input OR32(pre_or32, or32_result);

    assign extend_32[31:16] = shift5[31:16];
    assign extend_32[15:0] = shift5[31:16];
    mux_32 MUX_32_6(or32_result, shift5_result, extend_32, out);
endmodule

