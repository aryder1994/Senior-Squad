// MUX_5

module mux_5(sel, in0, in1, out);
    input          sel;
    input    [4:0] in0;
    input    [4:0] in1;
    output   [4:0] out;
    
    genvar i;
    generate
    for (i=0; i<5; i=i+1)
    begin: gen_loop
        mux MUX_N(sel, in0[i], in1[i], out[i]);
    end
    endgenerate
endmodule
