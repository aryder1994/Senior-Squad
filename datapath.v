// Datapath for Single Cycle Processor
module datapath(
		clk,
		rS1, rS2, rD,
		imm16,
		regDst, aluSrc, alu0, alu1, alu2, alu3, alu4, alu5, memWr, wSrc, regWr, memSign, loadHigh, link,
		dataSize,
		pcPlus4,
		zFlag, nzFlag,
		extendedImmOut,
		registerS1Out);
		
		input           clk;
		input     [4:0] rS1, rS2, rD;
		input    [15:0] imm16;
		input           regDst, aluSrc;
		input           alu0, alu1, alu2, alu3, alu4, alu5;
		input           memWr, wSrc, regWr, memSign, loadHigh, link;
		input     [1:0] dataSize;
		input    [31:0] pcPlus4;
		output          zFlag, nzFlag;
    output   [31:0] extendedImmOut;
    output   [31:0] registerS1Out;
    
    wire     [31:0] busA, busB, busW, aluA, preAluB, preAluB2, aluB, aluResult, memData, zeros, unflippedMemDataUnsigned;
    reg      [31:0] memDataSigned, memDataUnsigned, flippedAluResult, flippedBusB;
    wire      [4:0] rW, preRW;
    wire            preZFlag;
    wire     [31:0] shiftValue, extendedImm, immHigh, finalImm;
    wire      [1:0] flippedDataSize;
    
    assign zeros = 32'b00000000000000000000000000000000;
    
		assign extendedImmOut = extendedImm;
		assign registerS1Out = busA;
    
    register_file REGISTERS(clk, regWr, rS1, rS2, rW, busW, busA, busB);
    
    mux_5 REG_DST_MUX(regDst, rS2, rD, preRW);
    
    mux_5 REG_31_MUX(link, preRW, 5'b11111, rW);
        
    alu ALU_MODULE(aluA, aluB, alu0, alu1, alu2, alu3, alu4, alu5, aluResult);
    
    mux_32 ALU_A_MUX((loadHigh && link), busA, zeros, aluA);
    
    mux_32 ALU_B_MUX(aluSrc, busB, finalImm, preAluB);
    
    mux_32 ALU_B_MUX2(link, shiftValue, pcPlus4, preAluB2);
    
    mux_32 ALU_B_MUX3(((alu2 && (! alu5)) || link), preAluB, preAluB2, aluB);
    
    SignExtender EXTENDER(imm16, extendedImm);
    
    assign immHigh[31:16] = imm16;
    assign immHigh[15:0] = 116'b0000000000000000;
    
    mux_32 IMM_MUX(loadHigh, extendedImm, immHigh, finalImm);
    
    integer i;
    always @(unflippedMemDataUnsigned) begin
        for (i=0; i < 32; i=i+1) begin
            memDataUnsigned[i] <= unflippedMemDataUnsigned[31 - i];
        end
    end
    
    integer j;
    always @(aluResult) begin
        for (j=0; j < 32; j=j+1) begin
            flippedAluResult[j] <= aluResult[31 - j];
        end
    end
    
    integer k;
    always @(busB) begin
        for (k=0; k < 32; k=k+1) begin
            flippedBusB[k] <= busB[31 - k];
        end
    end
    
    assign flippedDataSize = {dataSize[0], dataSize[1]};
        
    dmem DATA_MEM(aluResult, unflippedMemDataUnsigned, busB, memWr, flippedDataSize, clk);
    
    mux_32 WR_MUX(wSrc, aluResult, memData, busW);
    
    or_32_input ZERO_CHECK(busA, preZFlag);
    
    assign zFlag = preZFlag;
    assign nzFlag = !preZFlag;
    
    assign shiftValue[31:5] = 27'b000000000000000000000000000;
    assign shiftValue[4:0] = preAluB[4:0];
    
    always @(memDataUnsigned) begin
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
  	      	default: begin
  	      	end
  	    endcase
  	end
  	
  	mux_32 MEM_SIGNED(memSign, memDataUnsigned, memDataSigned, memData);
  	
  	initial begin
  	    $readmemh("data.hex", DATA_MEM.mem);
  	end
endmodule
    