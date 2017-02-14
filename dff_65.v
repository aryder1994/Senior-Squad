// D Flip Flop

module dff_65(clk, d, q);
    input    clk;
    input    [64:0] d;
    output   [64:0] q;

    reg    [64:0] q;
    
    always @(posedge clk)
    begin
        q <= d;
    end
endmodule