// D Flip Flop

module dff_69(clk, d, q);
    input    clk;
    input    [68:0] d;
    output   [68:0] q;

    reg    [68:0] q;
    
    always @(posedge clk)
    begin
        q <= d;
    end
endmodule