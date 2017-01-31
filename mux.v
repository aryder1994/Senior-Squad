// Mux

module mux(sel, in0, in1, out);
    input    sel;
    input    in0;
    input    in1;
    output   out;
    
    assign out = ((!sel & in0) | (sel & in1));

endmodule
