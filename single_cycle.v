// Single Cycle Processor

module single_cycle(clk, pcSelect, startAddress);
    input           clk;
    input           pcSelect;
    input    [31:0] startAddress;
    
    wire            zFlag, nzFlag, BEQZ, BNEZ, jump, jumpReg;
    wire     [25:0] value;
    wire     [31:0] extendedImm, registerS1, instruction, pcPlus4;
    wire      [4:0] rS1, rS2, rD;
    wire     [15:0] imm16;
    wire            regDst, aluSrc, alu0, alu1, alu2, alu3, alu4, alu5, memWr, wSrc, regWr, memSign, loadHigh, link, endProgram;  
    wire      [1:0] dataSize;           
    
    fetch FETCH_UNIT(clk, pcSelect, startAddress, zFlag, nzFlag, BEQZ, BNEZ, jump, jumpReg, value, extendedImm, registerS1, instruction, pcPlus4, endProgram);
    
    control_signal CONTROL_UNIT(instruction, rS1, rS2, rD, imm16, regDst, aluSrc, alu0, alu1, alu2, alu3, alu4, alu5, memWr, wSrc, regWr, dataSize, memSign, loadHigh, link, BEQZ, BNEZ, jump, jumpReg, value);
    
    datapath DATAPATH_UNIT(clk, pcSelect, endProgram, rS1, rS2, rD, imm16, regDst, aluSrc, alu0, alu1, alu2, alu3, alu4, alu5, memWr, wSrc, regWr, memSign, loadHigh, link, dataSize, pcPlus4, zFlag, nzFlag, extendedImm, registerS1);
endmodule