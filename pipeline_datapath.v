// Datapath for Pipeline Processor

module pipeline_datapath(
		clk,
		reset,
		endProgram,
		rS1, rS2, rD,
		imm16,
		idCtrl, aluCtrl, exCtrl, memCtrl, wrCtrl,
		ifIdWrIn,
		pcPlus4, preInstruction,
		branch,
		stall,
		unshiftedMemDataUnsigned,
		fp_exCtrl, fp_regWrId,
		zFlag, nzFlag,
		extendedImmOut,
		registerS1Out,
		pcPlus4IdOut,
		instructionId,
		rWOut,
		aluResultMem,
		busBMem2,
		memWr,
		dataSize
		);
		
		input           clk;
		input           reset;
		input           endProgram;
		input     [4:0] rS1, rS2, rD;
		input    [15:0] imm16;
		input     [3:0] idCtrl;
		input     [5:0] aluCtrl;
		input     [6:0] exCtrl;
		input     [4:0] memCtrl;
		input     [1:0] wrCtrl;
		input           ifIdWrIn;
		input    [31:0] pcPlus4, preInstruction;
		input           branch;
		input           stall;
		input	   [31:0]	unshiftedMemDataUnsigned;
		input     [3:0] fp_exCtrl;
		input           fp_regWrId;
    output          zFlag, nzFlag;
    output   [31:0] extendedImmOut;
    output   [31:0] registerS1Out;
    output   [31:0] pcPlus4IdOut;
    output   [31:0] instructionId;
    output    [4:0] rWOut;
    output   [31:0] aluResultMem;
    output   [31:0] busBMem2;
    output          memWr;
    output    [1:0] dataSize;
    
    wire     [31:0] preBusA, busA, preBusB, busB, busW, preAluA, preAluA2, aluA;
    wire     [31:0] preAluB, preAluB2, preAluB3, preAluB4, aluB;
    wire     [31:0] aluResult, memData, zeros, unshiftedMemDataUnsigned;
    reg      [31:0] memDataSigned, memDataUnsigned;
    wire      [4:0] rW, preRW;
    wire            preNZFlag;
    wire     [31:0] shiftValue, extendedImm, immHigh, finalImm;
    wire            regDst, exMemIdA, exMemIdB, linkId;
    wire     [31:0] instruction;
    wire     [31:0] pcPlus4Id;
    wire     [31:0] pcPlus4Ex, extendedImmEx, busAEx, busBEx;
    wire      [4:0] rWEx, rWMem, rWWb;
    wire      [5:0] aluCtrlEx;
    wire      [6:0] exCtrlEx;
    wire      [4:0] memCtrlEx, memCtrlMem;
    wire      [1:0] wrCtrlEx, wrCtrlMem, wrCtrlWb;
    wire     [31:0] aluResultEx, busBMem, busBMem2;
    wire     [31:0] aluResultWb, memDataWb;
    wire            alu0, alu1, alu2, alu3, alu4, alu5;
    wire            aluSrc, loadHigh, link, exMemExA, exMemExB, memWbExA, memWbExB;
    wire      [1:0] dataSize;
    wire            memWr, memSign, memWbMem;
    wire            wSrc, regWr;
    wire            ifIdWr, prevStall;
    wire     [63:0] fp_preBusA, fp_busA, fp_busAEx, fp_busAEx2, fp_preBusB, fp_busB, fp_busBEx, fp_busBEx2;
    wire     [63:0] fp_busW, fp_busWEx, fp_busWMem;
    wire     [63:0] fp_product, fp_uproduct, fp_productFinal, fp_int;
    wire      [3:0] fp_exCtrlEx;
    wire            fp_regWrEx, fp_regWrMem, fp_regWr;
    wire            mulSelect, iToFp, fpToI, fp_exMemExA, fp_exMemExB, fp_memWbExA, fp_memWbExB;
    
    assign zeros = 32'b00000000000000000000000000000000;
    
      assign extendedImmOut = extendedImm;
      assign registerS1Out = busA;
      
      // IF STAGE
      
      assign ifIdWr = reset || ifIdWrIn;
      
      mux_32 INSTRUCTIONMUX(branch, preInstruction, zeros, instruction);
      
      ifIdRegister IFID(clk, ifIdWr, pcPlus4, instruction, pcPlus4Id, instructionId);
      
      // ID STAGE
      
      assign pcPlus4IdOut = pcPlus4Id;
      
      assign regDst = idCtrl[0];
      assign exMemIdA = idCtrl[1];
      assign exMemIdB = idCtrl[2];
      assign linkId = idCtrl[3];
      
      dff STALLER(clk, stall, prevStall);
    
    SignExtender EXTENDER(imm16, extendedImm);
    
    register_file REGISTERS(~clk, reset, regWr, rS1, rS2, rWWb, busW, preBusA, preBusB);
    fp_register_file FPREGISTERS(~clk, reset, fp_regWr, rS1, rS2, rWWb, fp_busW, fp_preBusA, fp_preBusB);
    
    mux_32 EXMEMIDA(exMemIdA, preBusA, aluResultMem, busA);
    mux_32 EXMEMIDB(exMemIdB, preBusB, aluResultMem, busB);
    
    mux_64 FPEXMEMIDA(exMemIdA, fp_preBusA, fp_busWMem, fp_busA);
    mux_64 FPEXMEMIDB(exMemIdB, fp_preBusB, fp_busWMem, fp_busB);
            
    mux_5 REG_DST_MUX(regDst, rS2, rD, preRW);
    
    mux_5 REG_31_MUX(linkId, preRW, 5'b11111, rW);
    
    assign rWOut = rW;
    
    or_32_input ZERO_CHECK(busA, preNZFlag);
    
    assign zFlag = ~preNZFlag;
    assign nzFlag = preNZFlag;
    
    idExRegister IDEX(clk, 1'b1, pcPlus4Id, extendedImm, busA, busB, rW,
    									aluCtrl, exCtrl, memCtrl, wrCtrl,
                           fp_busA, fp_busB, fp_exCtrl, fp_regWrId,
									pcPlus4Ex, extendedImmEx, busAEx, busBEx, rWEx,
								   aluCtrlEx, exCtrlEx, memCtrlEx, wrCtrlEx,
							      fp_busAEx, fp_busBEx, fp_exCtrlEx, fp_regWrEx);
  
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
    
    assign mulSelect = fp_exCtrlEx[0];
    assign iToFp = fp_exCtrlEx[1];
    assign fpToI = fp_exCtrlEx[2];
    assign enableMult = fp_exCtrlEx[3];
        
    mux_32 IMM_MUX(loadHigh, extendedImmEx, immHigh, finalImm);
    
    mux_32 EXMEMEXA(exMemExA, busAEx, aluResultMem, preAluA);
    mux_32 MEMWBEXA(memWbExA, preAluA, busW, preAluA2);
        
    mux_32 ALU_A_MUX((loadHigh || link), preAluA2, zeros, aluA);
    
    mux_32 EXMEMEXB(exMemExB, busBEx, aluResultMem, preAluB);
    mux_32 MEMWBEXB(memWbExB, preAluB, busW, preAluB2);
    
    mux_32 ALU_B_MUX(aluSrc, preAluB2, finalImm, preAluB3);
    
    assign shiftValue[31:5] = 27'b000000000000000000000000000;
    assign shiftValue[4:0] = preAluB3[4:0];
    
    mux_32 ALU_B_MUX2(link, shiftValue, pcPlus4Ex, preAluB4);
    
    mux_32 ALU_B_MUX3(((alu2 && (! alu5)) || link), preAluB3, preAluB4, aluB);
        
    alu ALU_MODULE(aluA, aluB, alu0, alu1, alu2, alu3, alu4, alu5, aluResult);
    
    mux_64 FPEXMEMEXA(exMemExA, fp_busAEx, fp_busWMem, fp_busAEx2);
    mux_64 FPEXMEMEXB(exMemExB, fp_busBEx, fp_busWMem, fp_busBEx2);
    
    multiplier MULT(clk, enableMult, fp_busAEx2[31:0], fp_busBEx2[31:0], fp_product);
    umultiplier UMULT(clk, enableMult, fp_busAEx2[31:0], fp_busBEx2[31:0], fp_uproduct);
    
    mux_64 MULTMUX(mulSelect, fp_product, fp_uproduct, fp_productFinal);
    
    assign fp_int[31:0] = aluResult;
    assign fp_int[63:32] = zeros;
    
    mux_64 I2FPMUX(iToFp, fp_productFinal, fp_int, fp_busWEx);
    
    mux_32 FP2IMUX(fpToI, aluResult, fp_busAEx2[31:0], aluResultEx);
    
    exMemRegister EXMEM(clk, 1'b1, aluResultEx, preAluB2, rWEx, memCtrlEx, wrCtrlEx,
                                   fp_busWEx, fp_regWrEx,
											  aluResultMem, busBMem, rWMem, memCtrlMem, wrCtrlMem,
											  fp_busWMem,fp_regWrMem);
    
    // MEM STAGE
    
    assign dataSize = memCtrlMem[1:0];
    assign memWr = memCtrlMem[2];
    assign memSign = memCtrlMem[3];
    assign memWbMem = memCtrlMem[4];
    
    mux_32 MEMWBMEM(memWbMem, busBMem, busW, busBMem2);
    
    //dmem DATA_MEM(aluResultMem, unshiftedMemDataUnsigned, busBMem2, memWr, dataSize, clk);
    
    always @(unshiftedMemDataUnsigned, dataSize) begin
  	    case (dataSize)
  	        2'b11: begin
  	            memDataSigned = unshiftedMemDataUnsigned;
  	            memDataUnsigned = unshiftedMemDataUnsigned;
  	        end
  	        2'b01: begin
  	      	    memDataSigned[31:16] = {16{unshiftedMemDataUnsigned[31]}};
  	      	    memDataSigned[15:0] = unshiftedMemDataUnsigned[31:16];
  	      	    memDataUnsigned[31:16] = 16'b0000000000000000;
  	      	    memDataUnsigned[15:0] = unshiftedMemDataUnsigned[31:16];
  	      	    
  	      	end
  	      	2'b00: begin
  	      	    memDataSigned[31:8] = {24{unshiftedMemDataUnsigned[31]}};
  	      	    memDataSigned[7:0] = unshiftedMemDataUnsigned[31:24];
  	      	    memDataUnsigned[31:8] = 24'b000000000000000000000000;
  	      	    memDataUnsigned[7:0] = unshiftedMemDataUnsigned[31:24];
  	      	end
  	      	default: begin
  	      	end
  	    endcase
  	end
  	
  	mux_32 MEM_SIGNED(memSign, memDataUnsigned, memDataSigned, memData);
  	
  	memWrRegister MEMWR(clk, 1'b1, aluResultMem, memData, rWMem, wrCtrlMem,
  	                    fp_busWMem, fp_regWrMem,
  	                    aluResultWb, memDataWb, rWWb, wrCtrlWb,
  	                    fp_busW, fp_regWr);
  	
  	// WR STAGE
  	
  	assign wSrc = wrCtrlWb[0];
  	assign regWr = wrCtrlWb[1];
    
    mux_32 WR_MUX(wSrc, aluResultWb, memDataWb, busW);
  	
  	always @(posedge endProgram) begin
  	    $writememh("results.hex", DATA_MEM.mem);
  	    //$finish;
  	end
endmodule
    