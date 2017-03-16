// D Flip Flop

module dff_2(clk, d, q);
    input          clk;
    input    [1:0] d;
    output   [1:0] q;

    reg    	 [1:0] q;
    
    always @(posedge clk)
    begin
        q <= d;
    end
endmodule