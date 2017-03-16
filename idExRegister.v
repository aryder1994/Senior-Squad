
module idExRegister(clk, write, pcPlus4Id, extendedImm, busA, busB, rW, aluCtrl, exCtrl, memCtrl, wrCtrl, fp_busA, fp_busB, fp_exCtrl, fp_rW, fp_regWrId,
pcPlus4Ex, extendedImmEx, busAEx, busBEx, rWEx, aluCtrlEx, exCtrlEx, memCtrlEx, wrCtrlEx, fp_busAEx, fp_busBEx, fp_exCtrlEx, fp_rWEx, fp_regWrEx);

  input clk, write;  
  input [31:0] pcPlus4Id, extendedImm, busA, busB;
  input [4:0] rW;
  input [5:0] aluCtrl;
  input [6:0] exCtrl;
  input [4:0] memCtrl;
  input [1:0] wrCtrl;
  input [63:0] fp_busA, fp_busB;
  input [6:0] fp_exCtrl;
  input [4:0] fp_rW;
  input       fp_regWrId;
  output reg [4:0] rWEx;
  output reg [31:0] pcPlus4Ex, extendedImmEx, busAEx, busBEx;
  output reg [5:0] aluCtrlEx;
  output reg [6:0] exCtrlEx;
  output reg [4:0] memCtrlEx;
  output reg [1:0] wrCtrlEx;
  output reg [63:0] fp_busAEx, fp_busBEx;
  output reg [6:0] fp_exCtrlEx;
  output reg [4:0] fp_rWEx;
  output reg       fp_regWrEx;
  		
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
               fp_busAEx = fp_busA;
               fp_busBEx = fp_busB;	
               fp_exCtrlEx = fp_exCtrl;
               fp_rWEx = fp_rW;
               fp_regWrEx = fp_regWrId;
				end

				else
				begin
					rWEx = rWEx;
					pcPlus4Ex = pcPlus4Ex;
					extendedImmEx = extendedImmEx;
					busAEx = busAEx;
					busBEx = busBEx;
					aluCtrlEx = aluCtrlEx;
					exCtrlEx = exCtrlEx;
					memCtrlEx = memCtrlEx;
					wrCtrlEx = wrCtrlEx;
               fp_busAEx = fp_busAEx;
               fp_busBEx = fp_busBEx;
               fp_exCtrlEx = fp_exCtrlEx;
               fp_rWEx = fp_rWEx;
               fp_regWrEx = fp_regWrEx;
				end
			end
endmodule