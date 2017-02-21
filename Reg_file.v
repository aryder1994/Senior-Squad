module Reg_file(rA, rB, rW, busW, busA, busB, regWr, clk);
  
  input [31:0] busW;
  input [4:0] rA, rB, rW; 
  input regWr, clk;
  
  output[31:0] busA, busB;
  reg [31:0] busA, busB;
  
  always@(busW, rA, rB, rW, regWr, clk)
    begin

			if(posedge clk & regWr == 1)
			begin
			
			register REGISTERN(busW,busA, busB, regWr, clk);
			
			end
      
    end
endmodule