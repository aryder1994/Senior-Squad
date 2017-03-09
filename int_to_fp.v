module int_to_fp(intgr,fp);

input [31:0]  intgr;

output [31:0] fp;


integer i;
reg [7:0] exp;
reg [22:0] mantissa;

assign fp = {intgr[31],exp,mantissa};

always@* 
begin
exp = 0;
mantissa = 0;

	if(intgr != 32'b0)begin
		for(i = 0; i < 32 ; i++)
			if(intgr[i])exp = i;
			
				if (exp > 23)
					mantissa = intgr >> (exp - 23);
				else if (exp < 23)
					mantissa = intgr << (23 - exp);
				else
					mantissa = intgr;
					
				exp = exp + 127;
				
	end
		
	
end
endmodule