// Single Cycle Fetch Unit

module fetch(clk, pcSelect, address, zFlag, nzFlag, BEQZ, BNEZ, extendedImm, instruction);
    input           clk;
    input           pcSelect;
    input    [31:0] startAddress;
    input           zFlag;
    input           nzFlag;
    input           BEQZ;
    input           BNEZ;
    input    [31:0] extendedImm;
    output   [31:0] instruction;
    
    wire     [31:0] currentAddress, preCurrentAddress, nextAddress;
    wire     [31:0] four;
    wire     [31:0] sumA, sumB;
    wire            cout, overflow;
    wire     [31:0] shiftedImm;
    
    assign four = 31'b00000000000000000000000000000100;
    
    imem INST_MEMORY(currentAddress[0:31], instruction[0:31]);
    
    mux_32 START(pcSelect, preCurrentAddress, startAddress, currentAddress);
    
    register_file: PC(clk, 1'b1, nextAddress, preCurrentAddress);
    
    adder_32 ADDER_1(currentAddress, four, 1'b0, sumA, cout, overflow);
    
    assign shiftedImm[31:2] = extendedImm[29:0];
    assign shiftedImm[1:0] = 2'b00;
    
    adder_32 ADDER_2(sumA, shiftedImm, 1'b0, sumB, cout, overflow);
    
    assign branch = ((zFlag and BEQZ) or (nzFlag and BNEZ));
    
    mux_32 NEXT_INSTRUCTION(branch, sumA, sumB, nextAddress);
endmodule