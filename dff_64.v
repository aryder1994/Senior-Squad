// D Flip Flop

module dff_64(clk, d, q);
    input    clk;
    input    [63:0] d;
    output   [63:0] q;

    reg    [63:0] q;
    
    always @(posedge clk)
    begin
        q <= d;
    end
endmodule