// sll_32.v

module
sll_32(a,b,out);
    input    [31:0] a;
    input    [31:0] b;
    output   [31:0] out;
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

    assign shift1[0] = 1'b0;
    assign shift1[31:1] = a[30:0];

    mux_32 MUX_32_1(b[0], a, shift1, shift1_result);

    assign shift2[1:0] = 2'b00;
    assign shift2[31:2] = shift1_result[29:0];

    mux_32 MUX_32_2(b[1], shift1_result, shift2, shift2_result);

    assign shift3[3:0] = 4'b0000;
    assign shift3[31:4] = shift2_result[27:0];

    mux_32 MUX_32_3(b[2], shift2_result, shift3, shift3_result);

    assign shift4[7:0] = 8'b00000000;
    assign shift4[31:8] = shift3_result[23:0];

    mux_32 MUX_32_4(b[3], shift3_result, shift4, shift4_result);

    assign shift5[15:0] = 16'b0000000000000000;
    assign shift5[31:16] = shift4_result[15:0];

    mux_32 MUX_32_5(b[4], shift4_result, shift5, shift5_result);

    assign pre_or32[4:0] = 5'b00000;
    assign pre_or32[31:5] = b[31:5];

    or_32_input OR32(pre_or32, or32_result);

    mux_32 MUX_32_6(or32_result, shift5_result, 32'b00000000000000000000000000000000, out);
endmodule
