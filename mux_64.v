// MUX_64

module mux_64(sel, in0, in1, out);
    input           sel;
    input    [63:0] in0;
    input    [63:0] in1;
    output   [63:0] out;
    
    genvar i;
    generate
    for (i=0; i<64; i=i+1)
    begin: gen_loop
        mux MUX_N(sel, in0[i], in1[i], out[i]);
    end
    endgenerate
endmodule
