//SET Operations


//SEQ

module seq(out, set);
    input out;
    output reg [31:0] set;
    always @(out)
    
    begin
        if(out == 1'b0)
            set = 32'b1;
        else
            set = 32'b0;
    end
endmodule


//SNE

module sne(out, set);
    input out;
    output reg [31:0] set;
    always @(out)
    
    begin
        if(out == 32'b0)
            set = 32'b0;
        else
            set = 32'b1;
    end
endmodule


//SLT

module slt(cout, set);
    input coutl
    output reg[31:0] set;
    always @(cout)

    begin
        if(cout == 1'b0)
            set = 32'b1;
        else
            set =32'b0;
        end
endmodule


//SGT

module sgt(out, cout, set);
    input out;
    input cout;
    output reg[31:0] set;
    always @(out or cout)
    begin
        if(cout == 1'b0 || out == 1'b0)
            set = 32'b0;
        else
            set = 32'b1;
    end
endmodule


//SLE

module sle(out, cout,set);
	input  out;
	input cout;
	output reg [31:0] set;

	always @(out or cout)
	begin
		if(cout == 1'b0 || out == 1'b0)
			set = 32'b1;
		else
			set = 32'b0;
	end
endmodule


//SGE

module sge(cout, set);
    input cout;
    output reg[31:0] set;
    always @(cout)

    begin
        if(cout == 1'b0)
            set = 32'b0;
        else
            set = 32'b1;
        end
endmodule


