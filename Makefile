AS = iverilog

#TARGET = mux.v mux_32.v or_32_input.v ALU_logical_1_bit.v ALU_logical_32.v sll_32.v srl_sra_32.v ALU_logical.v 1bit\ Adder.v 32bit\ Adder.v Set_operations.v alu_arith.v alu.v ALU_top_tb.v

TARGET = mux.v mux_33.v 1bit\ Adder.v 33bit\ Adder.v umultiplier_adder.v umultiplier_shifter.v umultiplier.v Unsigned_mult_tb.v

.PHONY: all $(TARGET) clean

all : $(TARGET)
	$(AS) $(TARGET)

clean:
	rm *.out
