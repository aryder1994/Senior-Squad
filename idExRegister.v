
module idExRegister(clk, write, pcPlus4Id, extendedImm, busA, busB, rW, aluCtrl, exCtrl, memCtrl, wrCtrl, pcPlus4Ex, extendedImmEx, busAEx, busBEx, rWEx, aluCtrlEx, exCtrlEx, memCtrlEx, wrCtrlEx);

  input clk, write;  
  input [31:0] pcPlus4Id, extendedImm, busA, busB;
  input [4:0] rW;
  input [5:0] aluCtrl;
  input [6:0] exCtrl;
  input [4:0] memCtrl;
  input [1:0] wrCtrl;
  output reg [4:0] rWEx;
  output reg [31:0] pcPlus4IdEx, extendedImmEx, busAEx, busBEx;
  output reg [5:0] aluCtrlEx;
  output reg [6:0] exCtrlEx;
  output reg [4:0] memCtrlEx;
  output reg [1:0] wrCtrlEx;
  		
		  always@(posedge clk) begin		
				if(write == 1)
				begin	
					rWEx = rW;
					pcPlus4Ex = pcPlus4Id;
					extendedImmEx = extendedImm;
					busAEx = busA;
					busBEx = busB;
					aluCtrlEx = aluCtrl;
					exCtrlEx = exCtrl;
					memCtrlEx = memCtrl;
					wrCtrlEx = wrCtrl;					
				end

				else
				begin
					rWEx = rWEx;
					pcPlus4Ex = pcPlus4IdEx;
					extendedImmEx = extendedImmEx;
					busAEx = busAEx;
					busBEx = busBEx;
					aluCtrlEx = aluCtrlEx;
					exCtrlEx = exCtrlEx;
					memCtrlEx = memCtrlEx;
					wrCtrlEx = wrCtrlEx;
				end
			end
endmodule