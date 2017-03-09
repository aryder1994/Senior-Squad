// Datapath for Single Cycle Processor

module datapath(
		clk,
		reset,
		endProgram,
		rS1, rS2, rD,
		imm16,
		regDst,
		aluCtrl, exCtrl, memCtrl, wrCtrl,
		pcPlus4,
		zFlag, nzFlag,
		extendedImmOut,
		registerS1Out,
		instructionId);
		
		input           clk;
		input           reset;
		input           endProgram;
		input     [4:0] rS1, rS2, rD;
		input    [15:0] imm16;
		input           regDst;
		input     [5:0] aluCtrl;
		input     [6:0] exCtrl;
		input     [4:0] memCtrl;
		input     [1:0] wrCtrl;
		input    [31:0] pcPlus4;
		output          zFlag, nzFlag;
    output   [31:0] extendedImmOut;
    output   [31:0] registerS1Out;
    
    wire     [31:0] busA, busB, busW, aluA, preAluB, preAluB2, aluB, aluResult, memData, zeros, unshiftedMemDataUnsigned;
    reg      [31:0] memDataSigned, memDataUnsigned;
    wire      [4:0] rW, preRW;
    wire            preNZFlag;
    wire     [31:0] shiftValue, extendedImm, immHigh, finalImm;
    
    assign zeros = 32'b00000000000000000000000000000000;
    
		assign extendedImmOut = extendedImm;
		assign registerS1Out = busA;
		
		// IF STAGE
			
		assign ifIdWr = pcSelect or ifIdWrIn;
		
		ifIdRegister IFID(clk, ifIdWr, pcPlus4, instruction, pcPlus4Id, instructionId);
		
		// ID STAGE
    
    SignExtender EXTENDER(imm16, extendedImm);
    
    register_file REGISTERS(clk, reset, regWr, rS1, rS2, rWWb, busW, busA, busB);
    
    mux_5 REG_DST_MUX(regDst, rS2, rD, preRW);
    
    mux_5 REG_31_MUX(link, preRW, 5'b11111, rW);
    
    or_32_input ZERO_CHECK(busA, preNZFlag);
    
    assign zFlag = ~preNZFlag;
    assign nzFlag = preNZFlag;
    
    idExRegister IDEX(clk, 1'b1, pcPlus4Id, extendedImm, busA, busB, rW,
    									aluCtrl, exCtrl, memCtrl, wrCtrl,
											pcPlus4Ex, extendedImmEx, busAEx, busBEx, rWEx,
											aluCtrlEx, exCtrlEx, memCtrlEx, wrCtrlEx);
  
    // EX STAGE
    
    assign immHigh[31:16] = extendedImmEx[15:0];
    assign immHigh[15:0] = 16'b0000000000000000;
    
    assign alu0 = aluCtrlEx[5];
    assign alu1 = aluCtrlEx[4];
    assign alu2 = aluCtrlEx[3];
    assign alu3 = aluCtrlEx[2];
    assign alu4 = aluCtrlEx[1];
    assign alu5 = aluCtrlEx[0]; 
    
    assign aluSrc = exCtrlEx[0];
    assign loadHigh = exCtrlEx[1];
    assign link = exCtrlEx[2];
    assign exMemExA = exCtrlEx[3];
    assign exMemExB = exCtrlEx[4];
    assign memWbExA = exCtrlEx[5];
    assign memWbExB = exCtrlEx[6];
        
    mux_32 IMM_MUX(loadHigh, extendedImmEx, immHigh, finalImm);
    
    assign shiftValue[31:5] = 27'b000000000000000000000000000;
    assign shiftValue[4:0] = preAluB[4:0];
    
    mux_32 ALU_A_MUX((loadHigh || link), busAEx, zeros, aluA);
    
    mux_32 ALU_B_MUX(aluSrc, busBEx, finalImm, preAluB);
    
    mux_32 ALU_B_MUX2(link, shiftValue, pcPlus4Ex, preAluB2);
    
    mux_32 ALU_B_MUX3(((alu2 && (! alu5)) || link), preAluB, preAluB2, aluB);
        
    alu ALU_MODULE(aluA, aluB, alu0, alu1, alu2, alu3, alu4, alu5, aluResult);
    
    exMemRegister EXMEM(clk, 1'b1, aluResult, busBEx, rWEx, memCtrlEx, wrCtrlEx,
											  aluResultMem, busBMem, rWMem, memCtrlMem, wrCtrlMem);
    
    // MEM STAGE
    
    assign dataSize = memCtrlMem[1:0];
    assign memWr = memCtrlMem[2];
    assign memSign = memCtrlMem[3];
    assign memWbMem = memCtrlMem[4];
        
    dmem DATA_MEM(aluResultMem, unshiftedMemDataUnsigned, busBMem, memWr, dataSize, clk);
    
    always @(unshiftedMemDataUnsigned) begin
  	    case (dataSize)
  	        2'b11: begin
  	            memDataSigned <= unshiftedMemDataUnsigned;
  	            memDataUnsigned <= unshiftedMemDataUnsigned;
  	        end
  	        2'b01: begin
  	      	    memDataSigned[31:16] <= {16{unshiftedMemDataUnsigned[31]}};
  	      	    memDataSigned[15:0] <= unshiftedMemDataUnsigned[31:16];
  	      	    memDataUnsigned[31:16] <= 16'b0000000000000000;
  	      	    memDataUnsigned[15:0] <= unshiftedMemDataUnsigned[31:16];
  	      	    
  	      	end
  	      	2'b00: begin
  	      	    memDataSigned[31:8] <= {24{unshiftedMemDataUnsigned[31]}};
  	      	    memDataSigned[7:0] <= unshiftedMemDataUnsigned[31:24];
  	      	    memDataUnsigned[31:8] <= 24'b000000000000000000000000;
  	      	    memDataUnsigned[7:0] <= unshiftedMemDataUnsigned[31:24];
  	      	end
  	      	default: begin
  	      	end
  	    endcase
  	end
  	
  	mux_32 MEM_SIGNED(memSign, memDataUnsigned, memDataSigned, memData);
  	
  	memWrRegister MEMWR(clk, 1'b1, aluResultMem, memData, rWMem, wrCtrlMem,
  	                    aluResultWb, memDataWb, rWWb, wrCtrlWb);
  	
  	// WR STAGE
  	
  	assign wSrc = wrCtrlWb[0];
  	assign regWr = wrCtrlWb[1];
    
    mux_32 WR_MUX(wSrc, aluResultWb, memDataWb, busW);  
  	
  	initial begin
  	    $readmemh("data.hex", DATA_MEM.mem);
  	end
  	
  	always @(posedge endProgram) begin
  	    $writememh("results.hex", DATA_MEM.mem);
  	    $finish;
  	end
endmodule
    