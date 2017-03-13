// Single Cycle Fetch Unit

module pipeline_fetch(clk, pcSelect, startAddress, stall, zFlag, nzFlag, BEQZ, BNEZ, jump, jumpReg, value, extendedImm, registerS1, pcPlus4Id, instruction, pcPlus4Out, branchOut, endProgram);
    input           clk;
    input           pcSelect;
    input    [31:0] startAddress;
    input           stall;
    input           zFlag;
    input           nzFlag;
    input           BEQZ;
    input           BNEZ;
    input           jump;
    input           jumpReg;
    input    [25:0] value;
    input    [31:0] extendedImm;
    input    [31:0] registerS1;
    input    [31:0] pcPlus4Id;
    output   [31:0] instruction;
    output   [31:0] pcPlus4Out;
    output          branchOut;
    output          endProgram;
    reg             endProgram;
    
    wire     [31:0] currentAddress, preCurrentAddress, preNextAddressA, preNextAddressB, preNextAddressC, nextAddress;
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
    
    adder_32 ADDER_2(pcPlus4Id, extendedImm, 1'b0, sumB, cout, overflow);
    
    assign branch = ((zFlag && BEQZ) || (nzFlag && BNEZ)) && ~stall;
    assign branchOut = branch;
    
    mux_32 NEXT_INSTRUCTION_A(stall, pcPlus4, currentAddress, preNextAddressA);
    
    mux_32 NEXT_INSTRUCTION_B(branch, preNextAddressA, sumB, preNextAddressB);
    
    adder_32 ADDER_3(pcPlus4Id, extendedValue, 1'b0, jumpValue, cout, overflow);
    
    mux_32 NEXT_INSTRUCTION_C(jumpReg, jumpValue, registerS1, preNextAddressC);
    
    mux_32 NEXT_INSTRUCTION(jump, preNextAddressB, preNextAddressC, nextAddress);
    
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