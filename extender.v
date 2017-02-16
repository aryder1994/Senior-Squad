module SignExtender(in, out);
  
  input[15:0] in;
  output[31:0] out;
  reg [31:0] out;
  
  always@(in)
    begin
      
      out[15:0]  = in[15:0];
      out[31:16] = {16{in[15]}};
      
    end
endmodule