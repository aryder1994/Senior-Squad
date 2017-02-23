// Single Cycle Fetch Unit

module fetch(clk, pcSelect, startAddress, zFlag, nzFlag, BEQZ, BNEZ, jump, jumpReg, value, extendedImm, registerS1, instruction, pcPlus4Out);
    input           clk;
    input           pcSelect;
    input    [31:0] startAddress;
    input           zFlag;
    input           nzFlag;
    input           BEQZ;
    input           BNEZ;
    input           jump;
    input           jumpReg;
    input    [25:0] value;
    input    [31:0] extendedImm;
    input    [31:0] registerS1;
    output   [31:0] instruction;
    output   [31:0] pcPlus4Out;
    
    reg      [31:0] instruction;
    
    wire     [31:0] currentAddress, preCurrentAddress, preNextAddressA, preNextAddressB, nextAddress, unflippedInstruction;
    reg      [31:0] flippedCurrentAddress;
    wire     [31:0] four;
    wire     [31:0] pcPlus4, sumB, extendedValue;
    wire            cout, overflow;
    wire     [31:0] shiftedImm;
    
    assign four = 32'b00000000000000000000000000000100;
    
    integer i;
    always @(currentAddress) begin
        for (i=0; i < 32; i=i+1) begin
            flippedCurrentAddress[i] <= currentAddress[31 - i];
        end
    end
    
    integer j;
    always @(unflippedInstruction) begin
        for (j=0; j < 32; j=j+1) begin
            instruction[j] <= unflippedInstruction[31 - j];
        end
    end
    
    imem INST_MEMORY(flippedCurrentAddress, unflippedInstruction);
    
    mux_32 START(pcSelect, preCurrentAddress, startAddress, currentAddress);
    
    register PC(nextAddress, preCurrentAddress, 1'b1, clk);
    
    adder_32 ADDER_1(currentAddress, four, 1'b0, pcPlus4, cout, overflow);
    
    assign pcPlus4Out = pcPlus4;
    
    assign extendedValue[25:0] = value;
    assign extendedValue[31:26] = {6{value[25]}};
    
    assign shiftedImm[31:2] = extendedImm[29:0];
    assign shiftedImm[1:0] = 2'b00;
    
    adder_32 ADDER_2(pcPlus4, shiftedImm, 1'b0, sumB, cout, overflow);
    
    assign branch = ((zFlag && BEQZ) || (nzFlag && BNEZ));
    
    mux_32 NEXT_INSTRUCTION_A(branch, pcPlus4, sumB, preNextAddressA);
    
    mux_32 NEXT_INSTRUCTION_B(jumpReg, extendedValue, registerS1, preNextAddressB);
    
    mux_32 NEXT_INSTRUCTION(jump, preNextAddressA, preNextAddressB, nextAddress);
    
    initial begin
        $readmemh("instr.hex", INST_MEMORY);
    end
    
endmodule