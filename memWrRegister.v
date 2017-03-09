
module memWrRegister(clk, write, aluResultMem, memData, rWMem, wrCtrlMem, aluResultWb, memDataWb, rWWb, wrCtrlWb);

  input clk, write;  
  input [31:0] aluResultMem, memData;
  input [4:0] rWMem; 
  input [1:0] wrCtrlMem;
  output reg [4:0] rWWb;
  output reg [31:0] aluResultWb, memDataWb;  
  output reg [1:0] wrCtrlWb;
  		
		  always@(posedge clk) begin		
				if(write == 1)
				begin	
					rWWb = rWMem;
					aluResultWb = aluResultMem;
					memDataWb = memData;
					wrCtrlWb = wrCtrlMem;
				end

				else
				begin
					rWWb = rWWb;
					aluResultWb = aluResultWb;
					memDataWb = memDataWb;
					wrCtrlWb = wrCtrlWb;
				end
			end
endmodule