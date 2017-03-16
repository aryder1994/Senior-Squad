// MUX_34

module mux_34(sel, in0, in1, out);
    input           sel;
    input    [33:0] in0;
    input    [33:0] in1;
    output   [33:0] out;
    
    genvar i;
    generate
    for (i=0; i<34; i=i+1)
    begin: gen_loop
        mux MUX_N(sel, in0[i], in1[i], out[i]);
    end
    endgenerate
endmodule
