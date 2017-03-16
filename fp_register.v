
module fp_register(clk, regWr, dataIn, dataOut);
  input clk, regWr;
  input [63:0] dataIn; 
  output[63:0] dataOut;
  reg   [63:0] dataOut;  
  		
		  always@(posedge clk) begin		
				if(regWr == 1)
				begin	
					dataOut = dataIn;
				end

				else
				begin
					dataOut = dataOut;
				end
			end
endmodule