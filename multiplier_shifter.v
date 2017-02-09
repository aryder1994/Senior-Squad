module multiplier_shifter(in, out);
     input   [63:0] in;
     output  [63:0] out;


     genvar i;

     generate
     for (i = 0; i < 63; i=i+1)
     begin
        out[i] = in[i+1];
     end
     endgenerate

     out[63] = in[63];
endmodule



