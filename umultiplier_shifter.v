module umultiplier_shifter(in, out);
     input   [66:0] in;
     output  [66:0] out;


     genvar i;

     generate
     for (i = 0; i < 66; i=i+1)
     begin
        assign out[i] = in[i+1];
     end
     endgenerate

     assign out[66] = in[66];
endmodule



