// Single Cycle Processor

module pipeline(clk, pcSelect, startAddress);
    input           clk;
    input           pcSelect;
    input    [31:0] startAddress;
    
    wire            zFlag, nzFlag, BEQZ, BNEZ, jump, jumpReg;
    wire     [25:0] value;
    wire     [31:0] extendedImm, registerS1, instruction, pcPlus4, pcPlus4Id, instructionId;
    wire      [4:0] rS1, rS2, rD, rW;
    wire     [15:0] imm16;
    wire            branch, endProgram, ifIdWr;  
    wire      [1:0] dataSize;  
   	wire      [2:0] idCtrl;
		wire      [5:0] aluCtrl;
		wire      [6:0] exCtrl;
		wire      [4:0] memCtrl;
		wire      [1:0] wrCtrl;
		
		assign ifIdWr = not stall;      
    
    pipeline_fetch FETCH_UNIT(clk, pcSelect, startAddress, zFlag, nzFlag, BEQZ, BNEZ, jump, jumpReg, value, extendedImm, registerS1, pcPlus4Id, instruction, pcPlus4, branch, endProgram);
    
    pipeline_control CONTROL_UNIT(instruction, rS1, rS2, rD, imm16, regDst, aluSrc, alu0, alu1, alu2, alu3, alu4, alu5, memWr, wSrc, regWr, dataSize, memSign, loadHigh, link, BEQZ, BNEZ, jump, jumpReg, value);
    
    pipeline_datapath DATAPATH_UNIT(clk, pcSelect, endProgram, rS1, rS2, rD, imm16, idCtrl, aluCtrl, exCtrl, memCtrl, wrCtrl, ifIdWr, pcPlus4, instruction, zFlag, nzFlag, extendedImm, registerS1, pcPlus4Id, instructionId, rW);
endmodule