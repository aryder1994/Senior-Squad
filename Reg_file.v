module Reg_file(rA, rB, rW, busW, bus, busA, busB, regWr, clk);
  
  input [31:0] busW;
  input [4:0] rA, rB, rW; 
  input regWr, clk;
  
  inout [31:0] bus;
  
  output[31:0] busA, busB;
  reg [31:0] busA, busB;
  
  always@(busW, rA, rB, rW, regWr, bus, clk)
    begin

			if(posedge clk & regWr == 1)
			begin
			
			register REGISTERn(busW, bus, regWr, clk);
			
			end
			
			if(posedge clk & rW == 1 & regWr == 1)
			begin
			
			register REGISTERn(bus, busA, rW, clk);
			
			end
			
			elsif(posedge clk & rW == 0 & regWr == 1)
			begin
			
			register REGISTERn(bus, busB, rW, clk);
			
			end
			
      
    end
endmodule