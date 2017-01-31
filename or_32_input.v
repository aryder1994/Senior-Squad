// 32 input OR gate

module or_4_input(in, out);
    input    [3:0] in;
    output         out;
    wire           line_a;
    wire           line_b;

    assign line_a = in[0] | in[1];
    assign line_b = in[2] | in[3];
      
    assign out = line_a | line_b;
endmodule

module or_8_input(in, out);
    input    [7:0] in;
    output         out;
    wire           line_a;
    wire           line_b;

    or_4_input OR_1(in[3:0], line_a);
    or_4_input OR_2(in[7:4], line_b);
      
    assign out = line_a | line_b;
endmodule

module or_16_input(in, out);
    input    [15:0] in;
    output          out;
    wire            line_a;
    wire            line_b;

    or_8_input OR_1(in[7:0], line_a);
    or_8_input OR_2(in[15:8], line_b);
      
    assign out = line_a | line_b;
endmodule

module or_32_input(in, out);
    input    [31:0] in;
    output          out;
    wire            line_a;
    wire            line_b;

    or_16_input OR_1(in[15:0], line_a);
    or_16_input OR_2(in[31:16], line_b);
    
    assign out = line_a | line_b;
endmodule 
