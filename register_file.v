
module register_file(clk, reset, regWr, rS1, rS2, rW, busWIn, busA, busB);
    input          clk;
    input          reset;
    input          regWr;
    input    [4:0] rS1, rS2, rW;
    input   [31:0] busWIn;
    output  [31:0] busA, busB;

    wire    [31:0] zeros, busW;
    wire    [31:0] r0,  r1,  r2,  r3,  r4,  r5,  r6,  r7,  r8,  r9;
    wire    [31:0] r10, r11, r12, r13, r14, r15, r16, r17, r18, r19;
    wire    [31:0] r20, r21, r22, r23, r24, r25, r26, r27, r28, r29;
    wire    [31:0] r30, r31;
    wire    [31:0] a_0_0, a_0_1,  a_0_2,  a_0_3,  a_0_4,  a_0_5,  a_0_6,  a_0_7;
    wire    [31:0] a_0_8, a_0_9, a_0_10, a_0_11, a_0_12, a_0_13, a_0_14, a_0_15;
    wire    [31:0] a_1_0, a_1_1,  a_1_2,  a_1_3,  a_1_4,  a_1_5,  a_1_6,  a_1_7;
    wire    [31:0] a_2_0, a_2_1,  a_2_2,  a_2_3,  a_3_0,  a_3_1,  a_4_0;
    wire    [31:0] b_0_0, b_0_1,  b_0_2,  b_0_3,  b_0_4,  b_0_5,  b_0_6,  b_0_7;
    wire    [31:0] b_0_8, b_0_9, b_0_10, b_0_11, b_0_12, b_0_13, b_0_14, b_0_15;
    wire    [31:0] b_1_0, b_1_1,  b_1_2,  b_1_3,  b_1_4,  b_1_5,  b_1_6,  b_1_7;
    wire    [31:0] b_2_0, b_2_1,  b_2_2,  b_2_3,  b_3_0,  b_3_1,  b_4_0;
    wire    [31:0] regWr_32_init, regWr_32, regWr_32_Regular, rW_32;
    wire           regWr_1,  regWr_2,  regWr_3,  regWr_4,  regWr_5,  regWr_6,  regWr_7,  regWr_8,  regWr_9;
    wire           regWr_10, regWr_11, regWr_12, regWr_13, regWr_14, regWr_15, regWr_16, regWr_17, regWr_18;
    wire           regWr_19, regWr_20, regWr_21, regWr_22, regWr_23, regWr_24, regWr_25, regWr_26, regWr_27;
    wire           regWr_28, regWr_29, regWr_30, regWr_31;

    assign zeros = 32'b00000000000000000000000000000000;

    mux_32 MUX(reset, busWIn, busWIn, busW);
    
    mux_32 WR_MUX(reset, regWr_32_Regular, 32'b11111111XXXXXXXXXXXXXXXXXXXXXXXX, regWr_32);

    register REG0(clk,1'b1,zeros,r0);

    register REG1(clk,regWr_1,busW,r1);

    register REG2(clk,regWr_2,busW,r2);

    register REG3(clk,regWr_3,busW,r3);

    register REG4(clk,regWr_4,busW,r4);
 
    register REG5(clk,regWr_5,busW,r5);

    register REG6(clk,regWr_6,busW,r6);

    register REG7(clk,regWr_7,busW,r7);

    register REG8(clk,regWr_8,busW,r8);

    register REG9(clk,regWr_9,busW,r9);

    register REG10(clk,regWr_10,busW,r10);

    register REG11(clk,regWr_11,busW,r11);

    register REG12(clk,regWr_12,busW,r12);

    register REG13(clk,regWr_13,busW,r13);

    register REG14(clk,regWr_14,busW,r14);

    register REG15(clk,regWr_15,busW,r15);

    register REG16(clk,regWr_16,busW,r16);

    register REG17(clk,regWr_17,busW,r17);

    register REG18(clk,regWr_18,busW,r18);

    register REG19(clk,regWr_19,busW,r19);

    register REG20(clk,regWr_20,busW,r20);

    register REG21(clk,regWr_21,busW,r21);

    register REG22(clk,regWr_22,busW,r22);

    register REG23(clk,regWr_23,busW,r23);

    register REG24(clk,regWr_24,busW,r24);

    register REG25(clk,regWr_25,busW,r25);

    register REG26(clk,regWr_26,busW,r26);

    register REG27(clk,regWr_27,busW,r27);

    register REG28(clk,regWr_28,busW,r28);

    register REG29(clk,regWr_29,busW,r29);

    register REG30(clk,regWr_30,busW,r30);
	     
    register REG31(clk,regWr_31,busW,r31);


    mux_32 MUX_a_0_0(rS1[0],r0,r1,a_0_0);

    mux_32 MUX_a_0_1(rS1[0],r2,r3,a_0_1);

    mux_32 MUX_a_0_2(rS1[0],r4,r5,a_0_2);

    mux_32 MUX_a_0_3(rS1[0],r6,r7,a_0_3);

    mux_32 MUX_a_0_4(rS1[0],r8,r9,a_0_4);

    mux_32 MUX_a_0_5(rS1[0],r10,r11,a_0_5);

    mux_32 MUX_a_0_6(rS1[0],r12,r13,a_0_6);

    mux_32 MUX_a_0_7(rS1[0],r14,r15,a_0_7);

    mux_32 MUX_a_0_8(rS1[0],r16,r17,a_0_8);

    mux_32 MUX_a_0_9(rS1[0],r18,r19,a_0_9);

    mux_32 MUX_a_0_10(rS1[0],r20,r21,a_0_10);

    mux_32 MUX_a_0_11(rS1[0],r22,r23,a_0_11);

    mux_32 MUX_a_0_12(rS1[0],r24,r25,a_0_12);

    mux_32 MUX_a_0_13(rS1[0],r26,r27,a_0_13);

    mux_32 MUX_a_0_14(rS1[0],r28,r29,a_0_14);

    mux_32 MUX_a_0_15(rS1[0],r30,r31,a_0_15);

    mux_32 MUX_a_1_0(rS1[1],a_0_0,a_0_1,a_1_0);

    mux_32 MUX_a_1_1(rS1[1],a_0_2,a_0_3,a_1_1);

    mux_32 MUX_a_1_2(rS1[1],a_0_4,a_0_5,a_1_2);

    mux_32 MUX_a_1_3(rS1[1],a_0_6,a_0_7,a_1_3);

    mux_32 MUX_a_1_4(rS1[1],a_0_8,a_0_9,a_1_4);

    mux_32 MUX_a_1_5(rS1[1],a_0_10,a_0_11,a_1_5);

    mux_32 MUX_a_1_6(rS1[1],a_0_12,a_0_13,a_1_6);

    mux_32 MUX_a_1_7(rS1[1],a_0_14,a_0_15,a_1_7);

    mux_32 MUX_a_2_0(rS1[2],a_1_0,a_1_1,a_2_0);

    mux_32 MUX_a_2_1(rS1[2],a_1_2,a_1_3,a_2_1);

    mux_32 MUX_a_2_2(rS1[2],a_1_4,a_1_5,a_2_2);

    mux_32 MUX_a_2_3(rS1[2],a_1_6,a_1_7,a_2_3);

    mux_32 MUX_a_3_0(rS1[3],a_2_0,a_2_1,a_3_0);

    mux_32 MUX_a_3_1(rS1[3],a_2_2,a_2_3,a_3_1);

    mux_32 MUX_a_4_0(rS1[4],a_3_0,a_3_1,busA);


    mux_32 MUX_b_0_0(rS2[0],r0,r1,b_0_0);

    mux_32 MUX_b_0_1(rS2[0],r2,r3,b_0_1);

    mux_32 MUX_b_0_2(rS2[0],r4,r5,b_0_2);

    mux_32 MUX_b_0_3(rS2[0],r6,r7,b_0_3);

    mux_32 MUX_b_0_4(rS2[0],r8,r9,b_0_4);

    mux_32 MUX_b_0_5(rS2[0],r10,r11,b_0_5);

    mux_32 MUX_b_0_6(rS2[0],r12,r13,b_0_6);

    mux_32 MUX_b_0_7(rS2[0],r14,r15,b_0_7);

    mux_32 MUX_b_0_8(rS2[0],r16,r17,b_0_8);

    mux_32 MUX_b_0_9(rS2[0],r18,r19,b_0_9);

    mux_32 MUX_b_0_10(rS2[0],r20,r21,b_0_10);

    mux_32 MUX_b_0_11(rS2[0],r22,r23,b_0_11);

    mux_32 MUX_b_0_12(rS2[0],r24,r25,b_0_12);

    mux_32 MUX_b_0_13(rS2[0],r26,r27,b_0_13);

    mux_32 MUX_b_0_14(rS2[0],r28,r29,b_0_14);

    mux_32 MUX_b_0_15(rS2[0],r30,r31,b_0_15);

    mux_32 MUX_b_1_0(rS2[1],b_0_0,b_0_1,b_1_0);

    mux_32 MUX_b_1_1(rS2[1],b_0_2,b_0_3,b_1_1);

    mux_32 MUX_b_1_2(rS2[1],b_0_4,b_0_5,b_1_2);

    mux_32 MUX_b_1_3(rS2[1],b_0_6,b_0_7,b_1_3);

    mux_32 MUX_b_1_4(rS2[1],b_0_8,b_0_9,b_1_4);

    mux_32 MUX_b_1_5(rS2[1],b_0_10,b_0_11,b_1_5);

    mux_32 MUX_b_1_6(rS2[1],b_0_12,b_0_13,b_1_6);

    mux_32 MUX_b_1_7(rS2[1],b_0_14,b_0_15,b_1_7);

    mux_32 MUX_b_2_0(rS2[2],b_1_0,b_1_1,b_2_0);

    mux_32 MUX_b_2_1(rS2[2],b_1_2,b_1_3,b_2_1);

    mux_32 MUX_b_2_2(rS2[2],b_1_4,b_1_5,b_2_2);

    mux_32 MUX_b_2_3(rS2[2],b_1_6,b_1_7,b_2_3);

    mux_32 MUX_b_3_0(rS2[3],b_2_0,b_2_1,b_3_0);
 
    mux_32 MUX_b_3_1(rS2[3],b_2_2,b_2_3,b_3_1);

    mux_32 MUX_b_4_0(rS2[4],b_3_0,b_3_1,busB);


    assign regWr_32_init[31:1] = 31'b0000000000000000000000000000000;
    assign regWr_32_init[0] = regWr;
    assign rW_32[31:5] = 27'b000000000000000000000000000;
    assign rW_32[4:0] = rW;

		sll_32 SHIFT(regWr_32_init,rW_32,regWr_32_Regular);

    assign regWr_1 = regWr_32[1];
    assign regWr_2 = regWr_32[2];
    assign regWr_3 = regWr_32[3];
    assign regWr_4 = regWr_32[4];
    assign regWr_5 = regWr_32[5];
    assign regWr_6 = regWr_32[6];
    assign regWr_7 = regWr_32[7];
    assign regWr_8 = regWr_32[8];
    assign regWr_9 = regWr_32[9];
    assign regWr_10 = regWr_32[10];
    assign regWr_11 = regWr_32[11];
    assign regWr_12 = regWr_32[12];
    assign regWr_13 = regWr_32[13];
    assign regWr_14 = regWr_32[14];
    assign regWr_15 = regWr_32[15];
    assign regWr_16 = regWr_32[16];
    assign regWr_17 = regWr_32[17];
    assign regWr_18 = regWr_32[18];
    assign regWr_19 = regWr_32[19];
    assign regWr_20 = regWr_32[20];
    assign regWr_21 = regWr_32[21];
    assign regWr_22 = regWr_32[22];
    assign regWr_23 = regWr_32[23];
    assign regWr_24 = regWr_32[24];
    assign regWr_25 = regWr_32[25];
    assign regWr_26 = regWr_32[26];
    assign regWr_27 = regWr_32[27];
    assign regWr_28 = regWr_32[28];
    assign regWr_29 = regWr_32[29];
    assign regWr_30 = regWr_32[30];
    assign regWr_31 = regWr_32[31];
endmodule