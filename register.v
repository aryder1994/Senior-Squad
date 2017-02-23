module register(dataIn, dataOut, regWr, clk);
  
  input [31:0] dataIn;
  input regWr, clk;
  
  output[31:0] dataOut
  reg dataOut;  
  		
		  always@(clk, dataIn, regWr)			
			begin
			
				if(posedge clk & regWr == 1)
				begin	
				
					dataOut = dataIn;
				end
				
				else
				begin
				
					dataOut;
				
				end
			end
	      

endmodule