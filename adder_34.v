// 34-bit Adder

module adder_34(a,b,cin,sum,cout,overflow);
   input   [33:0] a, b;
   input          cin;
   output  [33:0] sum;
   output         cout;
   output         overflow;
   wire	   [32:0] c;

   adder ADDER0(a[0], b[0], cin, sum[0], c[0]);

   genvar i;
   generate
   for (i = 1; i < 33; i=i+1)
   begin: gen_loop
         adder ADDERn(a[i], b[i], c[i-1], sum[i], c[i]);
   end
   endgenerate

   adder ADDER33(a[33], b[33], c[32], sum[33], cout);

   assign overflow = ((cout && !c[32]) || (!cout && c[32]));
endmodule
