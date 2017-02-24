// Single Cycle Fetch Unit

module fetch(clk, pcSelect, startAddress, zFlag, nzFlag, BEQZ, BNEZ, jump, jumpReg, value, extendedImm, registerS1, instruction, pcPlus4Out, endProgram);
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
    output          endProgram;
    reg             endProgram;
    
    wire     [31:0] currentAddress, preCurrentAddress, preNextAddressA, preNextAddressB, nextAddress;
    wire     [31:0] four;
    wire     [31:0] pcPlus4, sumB, extendedValue, jumpValue;
    wire            cout, overflow;
    wire     [31:0] shiftedImm;
    
    assign four = 32'b00000000000000000000000000000100;
    
    imem INST_MEMORY(currentAddress, instruction);
    
    mux_32 START(pcSelect, preCurrentAddress, startAddress, currentAddress);
    
    register PC(clk, ~endProgram, nextAddress, preCurrentAddress);
    
    adder_32 ADDER_1(currentAddress, four, 1'b0, pcPlus4, cout, overflow);
    
    assign pcPlus4Out = pcPlus4;
    
    assign extendedValue[25:0] = value;
    assign extendedValue[31:26] = {6{value[25]}};
    
    adder_32 ADDER_2(pcPlus4, extendedImm, 1'b0, sumB, cout, overflow);
    
    assign branch = ((zFlag && BEQZ) || (nzFlag && BNEZ));
    
    mux_32 NEXT_INSTRUCTION_A(branch, pcPlus4, sumB, preNextAddressA);
    
    adder_32 ADDER_3(pcPlus4, extendedValue, 1'b0, jumpValue, cout, overflow);
    
    mux_32 NEXT_INSTRUCTION_B(jumpReg, jumpValue, registerS1, preNextAddressB);
    
    mux_32 NEXT_INSTRUCTION(jump, preNextAddressA, preNextAddressB, nextAddress);
    
    initial begin
        $readmemh("instr.hex", INST_MEMORY.mem);
    end
    
    always @(instruction) begin
        if (instruction[11:0] == 12'b001100000000) begin
            endProgram <= 1'b1;
        end
        else begin
            endProgram <= 1'b0;
        end
    end
endmodule