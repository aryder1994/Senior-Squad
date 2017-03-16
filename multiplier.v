// signed Multiplier

module multiplier(clk, start, in1, in2, out);
    input           clk;
    input           start;
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
    
    wire [1:0] counter, counterNextWire;
    reg  [1:0] counterNext;
    reg         set;

    assign zeros = 32'b00000000000000000000000000000000;
    
    assign shifted_temp_out_d[0][32:1] = in1;
    assign shifted_temp_out_d[0][64:33] = zeros;
    assign shifted_temp_out_d[0][0] = 1'b0;
    assign counterNextWire = counterNext;
    
    dff_65 DFF8(clk, shifted_temp_out_d[8], shifted_temp_out_q[8]);
		dff_65 DFF16(clk, shifted_temp_out_d[16], shifted_temp_out_q[16]);
		dff_65 DFF24(clk, shifted_temp_out_d[24], shifted_temp_out_q[24]);
		dff_65 DFF32(clk, shifted_temp_out_d[32], shifted_temp_out_q[32]);
    dff_64 SET(set, shifted_temp_out_d[32][64:1], out);
    dff_2 COUNTREG(clk, counterNextWire, counter);

    genvar i;
    generate
    for (i = 0; i < 32; i=i+1)
    begin
				if (i != 8 && i != 16 && i != 24 && i != 32)
				    assign shifted_temp_out_q[i] = shifted_temp_out_d[i];
        assign sel0[i] = shifted_temp_out_q[i][0];
        assign sel1[i] = shifted_temp_out_q[i][0] ^ shifted_temp_out_q[i][1];
        multiplier_adder ADD_SUB_N(shifted_temp_out_q[i][64:33], in2, sel0[i], sel1[i], temp_out_top[i]);
        assign temp_out[i][32:0] = shifted_temp_out_q[i][32:0];
        assign temp_out[i][64:33] = temp_out_top[i];
        multiplier_shifter SHIFT_N(temp_out[i][64:0], shifted_temp_out_d[i+1][64:0]);
    end
    endgenerate
    
    always @(negedge clk)
    begin
        counterNext = 2'b00;
      	 if (start == 1'b1)
      	 begin
         	 case (counter)
         	    2'b00:
         	    begin
         	        counterNext = 2'b01;
         	    end
         	    
         	    2'b01:
                begin
                    counterNext = 2'b10;
                end
                
                2'b10:
                begin
                    counterNext = 2'b11;
                end
                
                2'b11:
                begin
                    counterNext = 2'b00;
                    set = 1;
                end
            endcase
        end
   end
endmodule
