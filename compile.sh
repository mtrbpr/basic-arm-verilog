TARGETDIR="target"
WAVEDIR="waves"
DUMP="dump.lx2"
if [ -d "$TARGETDIR" ]; then
	rm -r "$TARGETDIR"
fi

if [ -d "$WAVEDIR" ]; then
        rm -r "$WAVEDIR"
fi

mkdir "$WAVEDIR"
mkdir "$TARGETDIR"

echo "Compile Instruction Fetch stage ..."
iverilog ./instruction_fetch/adder.v ./instruction_fetch/instruction_memory.v ./instruction_fetch/multiplexer.v ./instruction_fetch/pc_module.v ./instruction_fetch/instruction_fetch.v -o ./target/instruction_fetch

echo "Compile Instruction Decode stage ..."
iverilog ./instruction_decode/register_file.v ./instruction_decode/condition_check.v ./instruction_decode/control_unit.v ./instruction_decode/instruction_decode.v ./instruction_decode/instruction_decode_tb.v -o ./target/instruction_decode

echo "Generating wave forms for instruction decode ..."
vvp ./target/instruction_decode -lxt2 
mv $DUMP ./waves/INSTRUCTION_DECODE.lx2

echo "Compile Execution stage ..."
iverilog ./execution/mux32.v ./execution/alu.v ./execution/status_register.v ./execution/val2_gen.v ./execution/execution_tb.v -o ./target/execution

echo "Generating wave forms for execution ..."
vvp ./target/execution -lxt2 
mv $DUMP ./waves/EXECUTION.lx2

echo "Compile Memory stage ..."
iverilog ./memory/data_memory.v -o ./target/data_memory

echo "Compile Write Back stage ..."
iverilog ./write_back/write_back.v -o ./target/write_back

echo "Compile pipe registers ..."

echo "Compile execution register ..."
iverilog ./pipe_registers/execution_register.v -o ./target/execution_register
echo "Compile instruction decode register ..."
iverilog ./pipe_registers/instruction_decode_register.v -o ./target/instruction_decode_register
echo "Compile instruction fetch register ..."
iverilog ./pipe_registers/instruction_fetch_register.v -o ./target/instruction_fetch_register
echo "Compile memory register ..."
iverilog ./pipe_registers/memory_register.v -o ./target/memory_register

echo "Compile Hazard Detection Unit ..."
iverilog ./hazard_detection_unit/hazard_detection_unit_old.v -o ./target/hazard_detection_unit

echo "Compile Forwarding Unit ..."
iverilog ./forwarding_unit/forwarding_unit.v -o ./target/forwarding_unit

echo "Compile top module ..."
iverilog ./instruction_fetch/adder.v ./instruction_fetch/instruction_memory.v ./hazard_detection_unit/hazard_detection_unit_old.v ./forwarding_unit/forwarding_unit.v ./instruction_fetch/multiplexer.v ./instruction_fetch/pc_module.v ./instruction_fetch/instruction_fetch.v ./instruction_decode/register_file.v ./instruction_decode/condition_check.v ./instruction_decode/control_unit.v ./instruction_decode/instruction_decode.v ./execution/mux32.v ./execution/alu.v ./execution/status_register.v ./execution/val2_gen.v ./execution/execution.v ./memory/data_memory.v ./write_back/write_back.v ./pipe_registers/execution_register.v ./pipe_registers/instruction_decode_register.v ./pipe_registers/instruction_fetch_register.v ./pipe_registers/memory_register.v ARM.v ARM_TOP.v -o ARM


#echo "Generating wave forms for ARM ..."
#vvp ARM -lxt2 
#mv $DUMP ./waves/ARM.lx2

echo "Opening gtkwave ..."


echo "Done Compiling !"
#gtkwave ./waves/ARM.lx2
