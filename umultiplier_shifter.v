module umultiplier_shifter(in, out);
     input   [68:0] in;
     output  [68:0] out;


     //genvar i;

     //generate
     //for (i = 0; i < 64; i=i+1)
     //begin
     //   assign out[i] = in[i+1];
     //end
     //endgenerate

     assign out[67:0] = in[68:1];

     assign out[68] = in[68];
endmodule



