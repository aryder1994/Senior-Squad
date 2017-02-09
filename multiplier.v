// Unsigned Multiplier

module multiplier(in1, in2, out);
    input    [31:0] in1;
    input    [31:0] in2;
    output   [63:0] out;

    wire [32:0] temp_out [64:0];
    wire [33:0] shifted_temp_out [64:0];
    wire [32:0] sel0;
    wire [32:0] sel1;

    assign shifted_temp_out[0][32:1] = in1;
    assign shifted_temp_out[0][64:33] = 32'b00000000000000000000000000000000;
    assign shifted_temp_out[0][0] = 1'b0;

    genvar i
    generate;
    for (i=0; i<=32; i=i+1)
    begin
        assign sel0[i] = shifted_temp_out[i][1];
        assign sel1[i] = !(shifted_temp_out[i][0] ^ shifted_temp_out[i][1]);
        multiplier_adder ADD_SUB_N(shifted_temp_out[i][64:33], in2, sel0[i], sel1[i], temp_out[i][64:33]);
        assign temp_out[i][32:0] = shifted_temp_out[i][32:0];
        multiplier_shifter SHIFT_N(temp_out[i][64:0], shifted_temp_out[i+1][64:0]);
    end
    endgenerate
    assign out = shifted_temp_out[33];
endmodule
