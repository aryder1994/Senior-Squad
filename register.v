module register(dataIn, dataOut, regWr, clk);
  
  input [31:0] dataIn;
  input regWr, clk;
  
  output[31:0] dataOut
  reg dataOut;  
  
  
  	genvar i;
	generate
		for (i = 0; i =< 31; i=i+1)  
		begin
		  always@(clk, dataIn, regWr)			
			begin
				if(posedge clk & regWr == 1)
				begin				
					assign dataOut[i] = dataIn[i];
				end
			end
		end	
	endgenerate		      

endmodule