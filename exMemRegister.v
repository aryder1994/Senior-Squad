
module exMemRegister(clk, write, aluResult, busBEx, rWEx, memCtrl, wrCtrlEx, fp_busWEx, fp_regWrEx,
aluResultMem, busBMem, rWMem, memCtrlMem, wrCtrlMem, fp_busWMem, fp_regWrMem);

  input clk, write;  
  input [31:0] aluResult, busBEx;
  input [4:0] rWEx, memCtrl; 
  input [1:0] wrCtrlEx;
  input [63:0] fp_busWEx;
  input       fp_regWrEx;
  output reg [4:0] rWMem, memCtrlMem;
  output reg [31:0] aluResultMem, busBMem;  
  output reg [1:0] wrCtrlMem;
  output reg [63:0] fp_busWMem;
  output reg       fp_regWrMem;
  		
		  always@(posedge clk) begin		
				if(write == 1)
				begin	
					rWMem = rWEx;
					memCtrlMem = memCtrl;
					aluResultMem = aluResult;
					busBMem = busBEx;
					wrCtrlMem = wrCtrlEx;
					fp_busWMem = fp_busWEx;
					fp_regWrMem = fp_regWrEx;
				end

				else
				begin
					rWMem = rWMem;
					memCtrlMem = memCtrlMem;
					aluResultMem = aluResultMem;
					busBMem = busBMem;
					wrCtrlMem = wrCtrlMem;
					fp_busWMem = fp_busWMem;
					fp_regWrMem = fp_regWrMem;
				end
			end
endmodule