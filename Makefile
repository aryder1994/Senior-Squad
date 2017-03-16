AS = iverilog

#ALU
#TARGET = mux.v mux_32.v or_32_input.v ALU_logical_1_bit.v ALU_logical_32.v sll_32.v srl_sra_32.v ALU_logical.v 1bit\ Adder.v 32bit\ Adder.v Set_operations.v alu_arith.v alu.v ALU_top_tb.v

#Unsigned Multiplier
#TARGET = dff_64.v dff_69.v mux.v mux_34.v 1bit\ Adder.v 34bit\ Adder.v umultiplier_adder.v umultiplier_shifter.v umultiplier.v Unsigned_Mult_tb.v

#Signed Multiplier
#TARGET = dff_64.v dff_65.v mux.v mux_32.v 1bit\ Adder.v 32bit\ Adder.v multiplier_adder.v multiplier_shifter.v multiplier.v Signed_Mult_tb.v

#Fetch
#TARGET = mux.v mux_32.v memory.v register.v or_32_input.v 1bit\ Adder.v 32bit\ Adder.v fetch.v

#Datapath
#TARGET = mux.v mux_32.v or_32_input.v ALU_logical_1_bit.v ALU_logical_32.v sll_32.v srl_sra_32.v ALU_logical.v 1bit\ Adder.v 32bit\ Adder.v Set_operations.v alu_arith.v alu.v ALU_top_tb.v register.v Reg_file.v extender.v memory.v datapath.v

#Single Cycle Processor
#TARGET = mux.v mux_5.v mux_32.v or_32_input.v ALU_logical_1_bit.v ALU_logical_32.v sll_32.v srl_sra_32.v ALU_logical.v 1bit\ Adder.v 32bit\ Adder.v Set_operations.v alu_arith.v alu.v register.v register_file.v extender.v memory.v datapath.v fetch.v control_signal.v single_cycle.v single_cycle_tb.v

#Pipeline Processor
TARGET = dff.v dff_2.v dff_5.v dff_64.v dff_65.v dff_69.v mux.v mux_5.v mux_32.v mux_34.v mux_64.v or_32_input.v ALU_logical_1_bit.v ALU_logical_32.v sll_32.v srl_sra_32.v ALU_logical.v adder.v adder_32.v adder_34.v Set_operations.v alu_arith.v alu.v register.v register_file.v fp_register.v fp_register_file.v extender.v memory.v ifIdRegister.v idExRegister.v exMemRegister.v memWrRegister.v multiplier_adder.v multiplier_shifter.v multiplier.v umultiplier_adder.v umultiplier_shifter.v umultiplier.v pipeline_datapath.v pipeline_fetch.v pipeline_control.v pipeline.v pipeline_tb.v


.PHONY: all $(TARGET) clean

all : $(TARGET)
	$(AS) $(TARGET)

clean:
	rm *.out
