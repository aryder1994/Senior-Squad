module multiplier_adder(a,b,sel0,sel1,out);
   input   [31:0] a, b;
   input          selo0, sel1;
   output  [31:0] out;
   
   
   wire	   [30:0] c;
   wire           cout;
   wire    [31:0] b_temp;


   always @(a or b or sel0 or sel1)

   begin

        if (sel1 == 1)                       //if sel1 == 1, out = a +/- b
            begin
                genvar i;
            
                begin
                    if (sel0 == 0)                   //if sel0 == 0, it's subtraction
                        b_temp = ~b + 1;             //set input b to two's compliment
                end

                adder ADDER0(a[0], b[0], sel0, out[0], c[0]);
                
                generate
                for (i = 1; i < 31; i=i+1)
                begin
                        adder ADDERn(a[i], b[i], sel0[i-1], out[i], c[i]);
                end
                endgenerate

                adder ADDER31(a[31], b[31], sel0[30], out[31], cout);
            end
        else                                 //if sel1 == 0, out = a
            out = a;            
    end

endmodule