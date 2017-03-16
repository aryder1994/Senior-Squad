// Unsigned Multiplier

module umultiplier(clk, start, in1, in2, out);

    input           clk;
    input           start;
    input    [31:0] in1;
    input    [31:0] in2;
    output   [63:0] out;

    wire [35:0] zeros;
    wire [33:0] extended_in2;
    wire [33:0] shifted_temp_out_init;
    wire [33:0] temp_out_top [33:0];
    wire [68:0] temp_out [33:0];
    wire [68:0] shifted_temp_out_d [34:0];
    wire [68:0] shifted_temp_out_q [34:0];
    wire [33:0] sel0;
    wire [33:0] sel1;
    wire [63:0] dummy;
    
    wire [1:0] counter, counterNextWire;
    reg  [1:0] counterNext;
    reg         set;

    assign zeros = 36'b0000000000000000000000000000000000;
    assign extended_in2[31:0] = in2;
    assign extended_in2[33:32] = 2'b00;
    assign shifted_temp_out_d[0][32:1] = in1;
    assign shifted_temp_out_d[0][68:33] = zeros;
    assign shifted_temp_out_d[0][0] = 1'b0;
    assign counterNextWire = counterNext;

		dff_69 DFF8(clk, shifted_temp_out_d[8], shifted_temp_out_q[8]);
		dff_69 DFF16(clk, shifted_temp_out_d[16], shifted_temp_out_q[16]);
		dff_69 DFF24(clk, shifted_temp_out_d[24], shifted_temp_out_q[24]);
		dff_69 DFF34(clk, shifted_temp_out_d[34], shifted_temp_out_q[34]);
    dff_64 SET(set, shifted_temp_out_d[34][64:1], out);
    dff_2 COUNTREG(clk, counterNextWire, counter);
	  genvar i;
		generate
		for (i = 0; i < 34; i=i+1)
		begin
				if (i != 8 && i != 16 && i != 24 && i != 34)
				    assign shifted_temp_out_q[i] = shifted_temp_out_d[i];
				assign sel0[i] = shifted_temp_out_q[i][0];
				assign sel1[i] = shifted_temp_out_q[i][0] ^ shifted_temp_out_q[i][1];
				umultiplier_adder ADD_SUB_N(shifted_temp_out_q[i][68:35], extended_in2, sel0[i], sel1[i], temp_out_top[i]);
				assign temp_out[i][34:0] = shifted_temp_out_q[i][34:0];
				assign temp_out[i][68:35] = temp_out_top[i];
				umultiplier_shifter SHIFT_N(temp_out[i][68:0], shifted_temp_out_d[i+1][68:0]);
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
