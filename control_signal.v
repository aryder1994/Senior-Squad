module control_signal(instr, rS1, rS2, rD, imm16, regDst, aluSrc, alu0, alu1, alu2, alu3, alu4, alu5, memWr, wSrc, regWr, dataSize, memSign, loadHigh, link, beqz, bnez, jump, jumpReg, value);

    input [31:0] instr;
    output reg regDst, aluSrc, alu0, alu1, alu2, alu3, alu4, alu5, memWr, wSrc, regWr, dataSize, memSign, loadHigh, link, beqz, bnez, jump, jumpReg, value;
	output reg [4:0] rS1, rS2, rD;
	output reg [15:0] imm16;


    always@(instr)

    begin


		rS1 = instr[25:21];
		rS2 = instr[20:16];
		rD = instr[15:11];
		imm16 = instr[15:0];
		aluSrc = instr[31] | instr[30] | instr[29];         //opcode 000xxx      pass rs2 or imm16
		memWr = instr[31] & ~instr[30] & instr[29];         // opcode 101xxx     Store 
		wSrc = instr[31] & ~instr[30] & ~instr[29];         //opcode 100xxx      Load
		regDst = ~(aluSrc | instr[28] | instr[27]);         //opcode 00000x      r-type or i-type
		
		dataSize = instr[27:26];
		memSign = 1;                 // signed
		loadHigh = 0;
		link = 0;
		beqz = 0;
		bnez = 0;
		jump = 0;
		value = instr[25:0];



		if (instr[31:29] == 3'b101 || instr[31:27] == 5'b01001 || instr[31:28] == 4'b0001 || instr [31:27] == 5'b00001)
		begin
			if (instr[31:29] == 3'b101)             // opcode 101xxx        Store
			begin
				regWr = 0;
				alu4 = 0;
				alu5 = 1;
			end

			else if (instr[31:27] == 5'b01001)      // JR & JALR
			begin
				if (instr[26] == 0)                 // JR
				begin
					regWr = 0;
					jump = 1;
					jumpReg = 1;
				end

				else                                // JALR
				begin
					regWr = 0;
					link = 1;
					jump = 1;
					jumpReg = 1;
					alu4 = 0;
					alu5 = 1;
				end
			end

			else if (instr[31:28] == 4'b0001)       // beqz & bnez
			begin
				if (instr[26] == 0)                 // beqz
				begin
					beqz = 1;
				end

				else                                // bnez
				begin
					bnez = 1;
				end

				regWr = 0;
			end

			else                                    // J & JAL
			begin
				if (instr[26] == 0)                 // J
				begin
					regWr = 0;
					jump = 1;
					jumpReg = 0;
				end

				else                                // JAL
				begin
					regWr = 1;
					link = 1;
					jump = 1;
					jumpReg = 0;
					alu4 = 0;
					alu5 = 1;
				end
			end

		end

		else                                        // LOAD
		begin
			if (instr == 32'b00000000000000000000000000010101)      // NOP
			begin
				regWr = 0;
			end
			else
			begin
				regWr = 1;                       // for rest of instructions, write to destination reg

				if (instr[31:29] == 3'b100)     // IF LOAD instructions, do addition
				begin
					alu4 = 0;
					alu5 = 1;
				end

				if (instr[31:28] == 4'b1001)            // LBU & LHU
				begin
					memSign = 0;                
				end

				if (instr[31:26] == 6'b001111)          // LHI
				begin
					loadHigh = 1;
					alu4 = 0;
					alu5 = 1;
				end


			end

		end

		 
		
		

		if (instr[31:26] == 6'b000000)      // r-type instructions opcode = 0  
	  

		begin
			case (instr[5:0])               // match by function
				6'b100000:                  // add            
				begin
					alu4 = 0;
					alu5 = 1;
				end

				6'b100001:                  // addu
				begin
					alu4 = 0;
					alu5 = 1;
				end


				6'b100010:                  // sub
				begin	
					alu3 = 1;
					alu4 = 1;
					alu5 = 1;     
				end
				
				6'b100011:                  // subu
				begin
					alu3 = 1;
					alu4 = 1;
					alu5 = 1;   
				end


				6'b100100:                  // and
				begin
					alu0 = 0;
					alu1 = 0;
					alu2 = 0;
					alu5 = 0;
				end

				6'b100101:                  // or
				begin
					alu0 = 1;
					alu1 = 0;
					alu2 = 0;
					alu5 = 0;
				end

				6'b100110:                  // xor
				begin
					
					alu1 = 1;
					alu2 = 0;               
					alu5 = 0;
				end
				
				6'b101000:                  // seq
				begin
					alu0 = 0;
					alu1 = 0;
					alu2 = 0;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end
				
				6'b101001:                  // sne
				begin
					alu0 = 1;
					alu1 = 0;
					alu2 = 0;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b101010:                  // slt
				begin
					alu0 = 0;
					alu1 = 1;
					alu2 = 0;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b101011:                  // sgt
				begin
					alu0 = 1;
					alu1 = 1;
					alu2 = 0;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b101100:                  // sle   
				begin
					alu1 = 0;
					alu2 = 1;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b101101:                  // sge 
				begin
					alu1 = 1;
					alu2 = 1;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end
				
				6'b100100:                  // sll
				begin	
					alu1 = 1;
					alu2 = 1;               
					alu5 = 0;
				end

				6'b000111:                  // sra
				begin
					alu0 = 0;
					alu1 = 0;
					alu2 = 1;                
					alu5 = 0;
				end

				6'b000110:                  // srl
				begin
					alu0 = 1;
					alu1 = 0;
					alu2 = 1;
					alu5 = 0;
				end
			endcase
		end
	   

		else                                // I-type instructions   

		begin   
			case (instr[31:26])               // match by function
				6'b001000:                  // addi            
				begin
					alu4 = 0;
					alu5 = 1;
				end

				6'b001001:                  // addui
				begin
					alu4 = 0;
					alu5 = 1;
				end


				6'b001010:                  // subi
				begin
					
					alu3 = 1;
					alu4 = 1;
					alu5 = 1;     
				end

				6'b001011:                  // subui
				begin
					alu3 = 1;
					alu4 = 1;
					alu5 = 1; 
				end


				6'b001100:                  // andi
				begin
					alu0 = 0;
					alu1 = 0;
					alu2 = 0;
					alu5 = 0;
				end

				6'b001101:                  // ori
				begin
					alu0 = 1;
					alu1 = 0;
					alu2 = 0;
					alu5 = 0;
				end

				6'b001110:                  // xori
				begin	
					alu1 = 1;
					alu2 = 0;               
					alu5 = 0;
				end
				
				6'b011000:                  // seqi
				begin
					alu0 = 0;
					alu1 = 0;
					alu2 = 0;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b011001:                  // snei
				begin
					alu0 = 1;
					alu1 = 0;
					alu2 = 0;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b011010:                  // slti
				begin
					alu0 = 0;
					alu1 = 1;
					alu2 = 0;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b011011:                  // sgti
				begin
					alu0 = 1;
					alu1 = 1;
					alu2 = 0;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b011100:                  // slei 
				begin
					alu1 = 0;
					alu2 = 1;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end

				6'b011101:                  // sgei      
				begin
					alu1 = 1;
					alu2 = 1;
					alu3 = 0;
					alu4 = 1;
					alu5 = 1;
				end
				
				6'b010100:                  // slli
				begin
					
					alu1 = 1;
					alu2 = 1;               
					alu5 = 0;
				end

				6'b010111:                  // srai
				begin
					alu0 = 0;
					alu1 = 0;
					alu2 = 1;                
					alu5 = 0;
				end

				6'b010110:                  // srli
				begin
					alu0 = 1;
					alu1 = 0;
					alu2 = 1;
					alu5 = 0;
				end
				
			endcase
		end

    end
endmodule




                












