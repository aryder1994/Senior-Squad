// MUX_33

module mux_33(sel, in0, in1, out);
    input           sel;
    input    [32:0] in0;
    input    [32:0] in1;
    output   [32:0] out;
    
    genvar i;
    generate
    for (i=0; i<33; i=i+1)
    begin
        mux MUX_N(sel, in0[i], in1[i], out[i]);
    end
    endgenerate
endmodule
