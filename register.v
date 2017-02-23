module register(dataIn, dataOut, regWr, clk);
  
  input [31:0] dataIn;
  input regWr, clk;
  
  output[31:0] dataOut;
  reg dataOut;  
  		
		  always@(posedge clk, dataIn, regWr)			
			
			
				if(regWr == 1 &&  clk)
				begin	
				
					dataOut = dataIn;
				end
				
				else
				begin
				
					dataOut = dataOut;
				
				end
			
	      

endmodule