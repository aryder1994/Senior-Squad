module Reg_file(rA, rB, rW, busW, busA, busB, regWr, clk);
  
  input [31:0] busW;
  input [4:0] rA, rB, rW; 
  input regWr, clk;
  
  inout [31:0] bus;
  
  output[31:0] busA, busB;
  reg [31:0] busA, busB;
  
  always@(busW, rA, rB, rW, regWr, bus, posedge clk)
    begin

			if(clk & regWr == 1)
			begin
			
			register REGISTERn(busW, bus, regWr, clk);
			
				
				
				if(clk & rW == 1 & regWr == 1)
				begin
				
				register REGISTERn(bus, busA, rW, clk);
				
				end
				
				else if(clk & rW == 0 & regWr == 1)
				begin
				
				register REGISTERn(bus, busB, rW, clk);
				
				end
			end
      
    end
endmodule