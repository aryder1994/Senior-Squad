module multiplier_shifter(in, out);
     input   [67:0] in;
     output  [67:0] out;


     //genvar i;

     //generate
     //for (i = 0; i < 64; i=i+1)
     //begin
     //   assign out[i] = in[i+1];
     //end
     //endgenerate

     assign out[66:0] = in[67:1];

     assign out[67] = in[67];
endmodule



