// signed Multiplier

module multiplier(clk, in1, in2, out);
    input           clk;
    input    [31:0] in1;
    input    [31:0] in2;
    output   [63:0] out;

    wire [31:0] ones;
    wire [31:0] zeros;
    wire [31:0] shifted_temp_out_init;
    wire [31:0] temp_out_top [31:0];
    wire [64:0] temp_out [31:0];
    wire [64:0] shifted_temp_out_d [32:0];
    wire [64:0] shifted_temp_out_q [32:0];
    wire [31:0] sel0;
    wire [31:0] sel1;
    wire [63:0] dummy;
    
    reg   [2:0] counter;
    reg         set;

    assign zeros = 32'b00000000000000000000000000000000;
    
    assign shifted_temp_out_d[0][32:1] = in1;
    assign shifted_temp_out_d[0][64:33] = zeros;
    assign shifted_temp_out_d[0][0] = 1'b0;
    
    dff_65 DFF0(clk, shifted_temp_out_d[0], shifted_temp_out_q[0]);
		dff_65 DFF8(clk, shifted_temp_out_d[8], shifted_temp_out_q[8]);
		dff_65 DFF16(clk, shifted_temp_out_d[16], shifted_temp_out_q[16]);
		dff_65 DFF24(clk, shifted_temp_out_d[24], shifted_temp_out_q[24]);
    dff_64 SET(set, shifted_temp_out_d[32][64:1], out);

    genvar i;
    generate
    for (i = 0; i < 32; i=i+1)
    begin
				if (i != 0 && i != 8 && i != 16 && i != 24)
				    assign shifted_temp_out_q[i] = shifted_temp_out_d[i];
        assign sel0[i] = shifted_temp_out_q[i][0];
        assign sel1[i] = shifted_temp_out_q[i][0] ^ shifted_temp_out_q[i][1];
        multiplier_adder ADD_SUB_N(shifted_temp_out_q[i][64:33], in2, sel0[i], sel1[i], temp_out_top[i]);
        assign temp_out[i][32:0] = shifted_temp_out_q[i][32:0];
        assign temp_out[i][64:33] = temp_out_top[i];
        multiplier_shifter SHIFT_N(temp_out[i][64:0], shifted_temp_out_d[i+1][64:0]);
    end
    endgenerate
		
		always @(posedge clk)
		begin
		    if (counter == 0 || counter == 1 || counter == 2)
		    begin
		        counter <= counter + 1;
		        set <= 0;
		    end
		    else
        begin
            counter <= 0;
            set <= 0;
        end
    end
    
    always @(negedge clk)
    begin
        if (counter == 3)
        begin
            set <= 1;
        end
    end		
endmodule
