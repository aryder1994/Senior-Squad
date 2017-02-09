// 33-bit Adder

module adder_33(a,b,cin,sum,cout,overflow);
   input   [32:0] a, b;
   input          cin;
   output  [32:0] sum;
   output         cout;
   output         overflow;
   wire	   [31:0] c;

   adder ADDER0(a[0], b[0], cin, sum[0], c[0]);

   genvar i;
   generate
   for (i = 1; i < 32; i=i+1)
   begin
         adder ADDERn(a[i], b[i], c[i-1], sum[i], c[i]);
   end
   endgenerate

   adder ADDER32(a[32], b[32], c[31], sum[32], cout);

   assign overflow = ((cout && !c[31]) || (!cout && c[31]));
endmodule
