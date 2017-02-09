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
   
   
   wire           cout;
   wire    [31:0] b_temp;
   wire    [31:0] b_new;
   wire    [31:0] c_in;
   wire    [31:0] sum;
   wire    overflow;

   assign b_temp = ~b;   


   mux_32 MUX_ADD_OR_SUBTRACT (sel0, b_temp, b, b_new);

   adder_32 ADDER0 (a, b_new, ~sel0, sum, cout, overflow);
   
   mux_32 MUX_OUTPUT (sel1, a, sum, out);

endmodule