// 32-bit Adder

module adder_32(a,b,cin,sum,cout,overflow);
   input   [31:0] a, b;
   input          cin;
   output  [31:0] sum;
   output         cout;
   output         overflow;
   wire	   [30:0] c;

   adder ADDER0(a[0], b[0], cin, sum[0], c[0]);

   genvar i;
   generate
   for (i = 1; i < 31; i=i+1)
   begin: gen_loop
         adder ADDERn(a[i], b[i], c[i-1], sum[i], c[i]);
   end
   endgenerate

   adder ADDER31(a[31], b[31], c[30], sum[31], cout);

   assign overflow = ((cout && !c[30]) || (!cout && c[30]));
endmodule
