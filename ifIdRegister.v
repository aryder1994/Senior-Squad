
module ifIdRegister(clk, ifIdWr, pcPlus4, instruction, pcPlus4Id, instructionId);
  input clk, regWr;
  input [31:0] pcPlus4, instruction; 
  output reg ifIdWr;
  output[31:0] pcPlus4Id, instructionId;
  reg   [31:0] pcPlus4Id, instructionId;  
  		
		  always@(posedge clk) begin		
				if(ifIdWr == 1)
				begin	
					instructionId = instruction;
					pcPlus4Id = pcPlus4;
				end

				else
				begin
					instructionId = instructionId;
					pcPlus4Id = pcPlus4Id;
				end
			end
endmodule