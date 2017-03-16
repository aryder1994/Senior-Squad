
module memWrRegister(clk, write, aluResultMem, memData, rWMem, wrCtrlMem, fp_busWMem, fp_regWrMem,
aluResultWb, memDataWb, rWWb, wrCtrlWb, fp_busW, fp_regWr);

  input clk, write;  
  input [31:0] aluResultMem, memData;
  input [4:0] rWMem; 
  input [1:0] wrCtrlMem;
  input [63:0] fp_busWMem;
  input fp_regWrMem;
  output reg [4:0] rWWb;
  output reg [31:0] aluResultWb, memDataWb;  
  output reg [1:0] wrCtrlWb;
  output reg [63:0] fp_busW;
  output reg       fp_regWr;
  		
		  always@(posedge clk) begin		
				if(write == 1)
				begin	
					rWWb = rWMem;
					aluResultWb = aluResultMem;
					memDataWb = memData;
					wrCtrlWb = wrCtrlMem;
					fp_busW = fp_busWMem;
					fp_regWr = fp_regWrMem;
				end

				else
				begin
					rWWb = rWWb;
					aluResultWb = aluResultWb;
					memDataWb = memDataWb;
					wrCtrlWb = wrCtrlWb;
					fp_busW = fp_busW;
					fp_regWr = fp_regWr;
				end
			end
endmodule