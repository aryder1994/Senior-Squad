
module exMemRegister(clk, write, aluResult, busBEx, rWEx, memCtrl, wrCtrlEx, aluResultMem, busBMem, rWMem, memCtrlMem, wrCtrlMem);

  input clk, write;  
  input [31:0] aluResult, busBEx;
  input [4:0] rWEx, memCtrlEx; 
  input [1:0] wrCtrlEx;
  output reg [4:0] rWMem, memCtrlMem;
  output reg [31:0] aluResultMem, busBMem;  
  output reg [1:0] wrCtrlMem;
  		
		  always@(posedge clk) begin		
				if(write == 1)
				begin	
					rWMem = rWEx;
					memCtrlMem = memCtrlEx;
					aluResultMem = aluResult;
					busBMem = busBEx;
					wrCtrlMem = wrCtrlEx;
				end

				else
				begin
					rWMem = rWMem;
					memCtrlMem = memCtrlMem;
					aluResultMem = aluResultMem;
					busBMem = busBMem;
					wrCtrlMem = wrCtrlMem;
				end
			end
endmodule