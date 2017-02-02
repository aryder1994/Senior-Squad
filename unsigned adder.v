// unsigned adder subtractor

module addu(a, b, cin, out);
    input cin;
    input [31:0] a;
    input [31:0] b;
    output [31:0] out;
    reg    [31:0] out;

    always @(a or b or cin)
    begin
        if (cin == 1'b0)
            out = a + b;
        else
            out = a - b;
    end
endmodule;