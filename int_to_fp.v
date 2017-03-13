module int_to_fp(intgr,fp);

input [31:0] intgr;
output [31:0] fp;

integer a;
reg [7:0] exponent = 0;
reg [22:0] mantissa = 0;
reg [31:0] new_intgr;

assign fp = {intgr[31],exponent,mantissa};
	
always@(intgr) 
begin
	if(intgr[31] == 1'b1)		
	begin
			new_intgr = {~intgr};
			new_intgr = new_intgr + 1;
	end
	else 
		new_intgr = intgr;
		
	if(new_intgr != 32'b0)
	begin
		for(a = 0; a < 32 ; a++)		
			if(new_intgr[a])			
				exponent = a;
			else
			
				if (exponent > 23)
					mantissa = new_intgr >> (exponent - 23);
				else if (exponent < 23)
					mantissa = new_intgr << (23 - exponent);
				else
					mantissa = new_intgr;	
					
			exponent = exponent + 127;
			
	end	
	else 
	exponent = 1;
end
endmodule