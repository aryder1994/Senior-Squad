// MUX_32

module mux_32(sel, in0, in1, out);
    input           sel;
    input    [31:0] in0;
    input    [31:0] in1;
    output   [31:0] out;
    
    genvar i;
    generate
    for (i=0; i<32; i=i+1)
    begin
        mux MUX_N(sel, in0[i], in1[i], out[i]);
    end
    endgenerate
endmodule
