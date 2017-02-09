//Adder & Subtractor for multiplier


// Control Signals
//      sel0    sel1
//ADD   1       x
//SUB   0       x
//OUT   x       1
//in1   x       0



module multiplier_adder(a,b,sel0,sel1,out);
   input   [31:0] a, b;
   input          sel0, sel1;
   output  [31:0] out;
   
   
   wire	   [30:0] c;
   wire           cout;
   wire    [31:0] b_temp;
   wire    [31:0] b_new;
   wire    [31:0] c_in;
   wire    [31:0] sum;

   b_temp = ~b + 1;
   c_in[0] = sel0;


   mux_32 MUX_ADD_OR_SUBTRACT (sel0, b_temp, b, b_new);

   genvar i;
   adder ADDER0(a[0], b_new[0], sel0, sum[0], c[0]);
                
   generate
   for (i = 1; i < 31; i=i+1)
   begin
           adder ADDERn(a[i], b_new[i], cin[i-1], sum[i], c[i]);
   end
   endgenerate

   adder ADDER31(a[31], b_new[31], cin[30], sum[31], cout);

   mux_32 MUX_OUTPUT (sel1, a, sum, out);

endmodule