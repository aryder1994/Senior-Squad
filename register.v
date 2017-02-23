module register(clk, regWr, dataIn, dataOut);
  input clk, regWr;
  input [31:0] dataIn; 
  output[31:0] dataOut;
  reg dataOut;  
  		
		  always@(posedge clk)			
				if(regWr == 1)
				begin	
					dataOut <= dataIn;
				end

				else
				begin
					dataOut <= dataOut;
				end
endmodule