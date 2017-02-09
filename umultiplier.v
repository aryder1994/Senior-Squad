// Unsigned Multiplier

module umultiplier(clk, in1, in2, out);

    input           clk;
    input           reset;
    input    [31:0] in1;
    input    [31:0] in2;
    output   [63:0] out;

    wire [34:0] zeros;
    wire [33:0] extended_in2;
    wire [33:0] shifted_temp_out_init;
    wire [33:0] temp_out_top [33:0];
    wire [68:0] temp_out [33:0];
    wire [68:0] shifted_temp_out [34:0];
    wire [33:0] sel0;
    wire [33:0] sel1;

    assign zeros = 36'b0000000000000000000000000000000000;
    assign extended_in2[31:0] = in2;
    assign extended_in2[33:32] = 2'b00;
    assign shifted_temp_out[0][32:1] = in1;
    assign shifted_temp_out[0][68:33] = zeros;
    assign shifted_temp_out[0][0] = 1'b0;
    
    reg [1:0] counter;

    always @(posedge reset)
    begin
        if (reset)
            counter <= 2'b0;
		end

    always @(posedge clk)
    begin   
        if (counter == 0)
						genvar i;
						generate
						for (i = 0; i < 8; i=i+1)
						begin
								assign sel0[i] = shifted_temp_out[i][0];
								assign sel1[i] = shifted_temp_out[i][0] ^ shifted_temp_out[i][1];
								umultiplier_adder ADD_SUB_N(shifted_temp_out[i][68:35], extended_in2, sel0[i], sel1[i], temp_out_top[i]);
								assign temp_out[i][34:0] = shifted_temp_out[i][34:0];
								assign temp_out[i][68:35] = temp_out_top[i];
								umultiplier_shifter SHIFT_N(temp_out[i][68:0], shifted_temp_out[i+1][68:0]);
						end
						endgenerate
				else if (counter == 1)
				    genvar i;
						generate
						for (i = 8; i < 16; i=i+1)
						begin
								assign sel0[i] = shifted_temp_out[i][0];
								assign sel1[i] = shifted_temp_out[i][0] ^ shifted_temp_out[i][1];
								umultiplier_adder ADD_SUB_N(shifted_temp_out[i][68:35], extended_in2, sel0[i], sel1[i], temp_out_top[i]);
								assign temp_out[i][34:0] = shifted_temp_out[i][34:0];
								assign temp_out[i][68:35] = temp_out_top[i];
								umultiplier_shifter SHIFT_N(temp_out[i][68:0], shifted_temp_out[i+1][68:0]);
						end
						endgenerate
				else if (counter == 2)
				    genvar i;
						generate
						for (i = 16; i < 24; i=i+1)
						begin
								assign sel0[i] = shifted_temp_out[i][0];
								assign sel1[i] = shifted_temp_out[i][0] ^ shifted_temp_out[i][1];
								umultiplier_adder ADD_SUB_N(shifted_temp_out[i][68:35], extended_in2, sel0[i], sel1[i], temp_out_top[i]);
								assign temp_out[i][34:0] = shifted_temp_out[i][34:0];
								assign temp_out[i][68:35] = temp_out_top[i];
								umultiplier_shifter SHIFT_N(temp_out[i][68:0], shifted_temp_out[i+1][68:0]);
						end
						endgenerate
				else if (counter == 3)
				    genvar i;
						generate
						for (i = 24; i < 34; i=i+1)
						begin
								assign sel0[i] = shifted_temp_out[i][0];
								assign sel1[i] = shifted_temp_out[i][0] ^ shifted_temp_out[i][1];
								umultiplier_adder ADD_SUB_N(shifted_temp_out[i][68:35], extended_in2, sel0[i], sel1[i], temp_out_top[i]);
								assign temp_out[i][34:0] = shifted_temp_out[i][34:0];
								assign temp_out[i][68:35] = temp_out_top[i];
								umultiplier_shifter SHIFT_N(temp_out[i][68:0], shifted_temp_out[i+1][68:0]);
						end
						endgenerate
				counter <= counter + 1;
		end
    assign out = shifted_temp_out[34][64:1];
endmodule
