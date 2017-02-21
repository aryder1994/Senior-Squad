// Datapath for Single Cycle Processor
module datapath(
		clk,
		rS1, rS2, rD,
		imm16,
		regDst, aluSrc, alu0, alu1, alu2, alu3, alu4, alu5, memWr, wSrc, regWr, memSign,
		dataSize,
		zFlag, nzFlag,
		extendedImm);
		
		input           clk;
		input     [4:0] rS1, rS2, rD;
		input    [15:0] imm16;
		input           regDst, aluSrc;
		input           alu0, alu1, alu2, alu3, alu4, alu5;
		input           memWr, wSrc, regWr, memSign;
		input     [1:0] dataSize;
		output          zFlag, nzFlag;
    output   [31:0] extendedImmOut;
    
    wire     [31:0] busA, busB, busW, aluA, prealuB, aluB, aluResult, memDataUnsigned, memData;
    reg      [31:0] memDataSigned;
    wire      [4:0] rW;
    wire            preZFlag;
    wire     [31:0] shiftValue, extendedImm;
    
    register_file REGISTERS(clk, regWr, rS1, rS2, rW, busW, aluA, busB);
    
    mux_5 REG_DST_MUX(regDst, rS2, rD, rW);
    
    alu ALU_MODULE(aluA, aluB, alu0, alu1, alu2, alu3, alu4, alu5, aluResult);
    
    mux_32 ALU_B_MUX(aluSrc, busB, extendedImm, prealuB);
    
    mux_32 ALU_B_MUX2((alu2 and (not alu5)), prealuB, shiftValue, aluB);
    
    SignExtender EXTENDER(imm16, extendedImm);
    
    dmem DATA_MEM(aluResult[0:31], memDataUnsigned[0:31], busB[0:31], memWr, dataSize[0:1], clk);
    
    mux_32 WR_MUX(wSrc, aluResult, memData, busW);
    
    or_32_input ZERO_CHECK(busA, preZFlag);
    
    assign zFlag = preZFlag;
    assign nzFlag = !preZFlag;
    
    assign shiftValue[31:5] = 27'b000000000000000000000000000;
    assign shiftValue[4:0] = prealuB[4:0];
    
    always @(memDataRaw) begin
  	    case (dataSize)
  	        2'b11: begin
  	            memDataSigned <= memDataUnsigned;
  	        end
  	        2'b01: begin
  	      	    memDataSigned[31:16] <= {16{memDataUnsigned[15]}};
  	      	    memDataSigned[15:0] <= memDataUnsigned[15:0];
  	      	end
  	      	2'b00: begin
  	      	    memDataSigned[31:8] <= {24{memDataUnsigned[7]}};
  	      	    memDataSigned[7:0] <= memDataUnsigned[7:0];
  	      	end
  	      	default:
  	    endcase
  	end
  	
  	mux_32 MEM_SIGNED(memSign, memDataUnsigned, memDataSigned, memData);
end module
    