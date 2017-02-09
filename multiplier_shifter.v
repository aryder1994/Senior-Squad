module multiplier_shifter(in, out);
     input   [64:0] in;
     output  [64:0] out;


     genvar i;

     generate
     for (i = 0; i < 64; i=i+1)
     begin
        assign out[i] = in[i+1];
     end
     endgenerate

     assign out[64] = in[64];
endmodule



