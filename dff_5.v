// D Flip Flop

module dff_5(clk, d, q);
    input    clk;
    input    [4:0] d;
    output   [4:0] q;

    reg    [4:0] q;
    
    always @(posedge clk)
    begin
        q <= d;
    end
endmodule