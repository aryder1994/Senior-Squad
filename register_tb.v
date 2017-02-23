`timescale 1ns/1ps
`include "register.v"

module regster_tb;
reg [31:0] dataIn;
reg regWr, clk;

wire[31:0] dataOut;

register REG0(
		.dataIn(dataIn),
		.regWr(regWr),
		.clk(clk),
		.dataOut(dataOut)
		);

initial
begin

$monitor("dataIn = %b,regWr = %b,clk = %b,dataOut = %b",dataIn, regWr, clk,dataOut);

#0 dataIn= $random; clk= 1'b1; regWr= 1'b1;
#1 dataIn= $random; clk= 1'b1; regWr= 1'b0;
#2 dataIn= $random; clk= 1'b1; regWr= 1'b1;
#3 dataIn= $random; clk= 1'b0; regWr= 1'b0;
#4 dataIn= $random; clk= 1'b1; regWr= 1'b1;
#5 dataIn= $random; clk= 1'b1; regWr= 1'b0;

end

endmodule
