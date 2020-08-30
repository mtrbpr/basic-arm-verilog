module ARM(
    input clk,
    input rst,
    input forwarding_enabled
);

wire hazard;
wire branch_taken;
wire [31:0] branch_adr;
wire [31:0] pc_if_out;
wire [31:0] instruction_if_out;

instruction_fetch inst_fetch(
	.clk	(clk),
	.rst	(rst),
	.freeze	(hazard),
	.branch_taken	(branch_taken),
	.branch_adr	(branch_adr),
	.pc_out	(pc_if_out),
	.instruction	(instruction_if_out)
);

wire [31:0] pc_if_reg_out;
wire [31:0] instruction_if_reg_out;

instruction_fetch_register inst_fetch_reg(
	.clk	(clk),
	.rst	(rst),
	.freeze	(hazard),
	.flush	(branch_taken),
	.pc_in(pc_if_out),
	.instruction_in	(instruction_if_out),
	.pc	(pc_if_reg_out),
	.instruction	(instruction_if_reg_out)
);
	
wire[31:0] result_wb;
wire write_back_enable;
wire [3:0] dest_wb;
wire [3:0] sr;
wire wb_en_id_out;
wire mem_r_en_id_out;
wire mem_w_en_id_out;
wire b_id_out;
wire s_id_out;
wire [3:0] exec_cmd_id_out;
wire [31:0] val_rn_id_out;
wire [31:0] val_rm_id_out;
wire imm_id_out;
wire [11:0] shift_operand_id_out;
wire [23:0] signed_imm_24_id_out;
wire [3:0] dest_id_out;
wire [3:0] src1_id_out;
wire [3:0] src2_id_out;
wire two_src_id_out;
wire [31:0] pc_id_out;
wire [31:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11;


instrcution_decode inst_decode(
	.clk	(clk),
	.rst	(rst),
	.instruction	(instruction_if_reg_out),
	.result_wb	(result_wb),
	.write_back_enable	(write_back_enable),
	.dest_wb	(dest_wb),
	.hazard	(hazard),
	.sr	(sr),
	.pc_in	(pc_if_reg_out),
	.R0(R0),
	.R1(R1),
	.R2(R2),
	.R3(R3),
	.R4(R4),
	.R5(R5),
	.R6(R6),
	.R7(R7),
	.R8(R8),
	.R9(R9),
	.R10(R10),
	.R11(R11),
	.wb_en	(wb_en_id_out),
	.mem_r_en	(mem_r_en_id_out),
	.mem_w_en	(mem_w_en_id_out),
	.b	(b_id_out),
	.s	(s_id_out),
	.exec_cmd	(exec_cmd_id_out),
	.val_rn	(val_rn_id_out),
	.val_rm	(val_rm_id_out),
	.imm		(imm_id_out),
	.shift_operand	(shift_operand_id_out),
	.signed_imm_24	(signed_imm_24_id_out),
	.dest	(dest_id_out),
	.src1	(src1_id_out),
	.src2	(src2_id_out),
	.two_src	(two_src_id_out),
	.pc_out	(pc_id_out)
);

wire wb_en_id_reg_out;
wire mem_r_en_id_reg_out;
wire mem_w_en_id_reg_out;
wire b_id_reg_out;
wire s_id_reg_out;
wire [3:0] exe_cmd_id_reg_out;
wire [31:0] pc_id_reg_out;
wire [31:0] val_rn_id_reg_out;
wire [31:0] val_rm_id_reg_out;
wire imm_id_reg_out;
wire [11:0] shift_operand_id_reg_out;
wire [23:0] signed_imm_24_id_reg_out;
wire [3:0] dest_id_reg_out;
wire [3:0] sr_id_reg_out;
wire [3:0] src1_id_reg_out;
wire [3:0] src2_id_reg_out;

instruction_decode_register inst_decode_reg(
	.clk	(clk),
	.rst	(rst),
	.flush	(branch_taken),
	.wb_en_in	(wb_en_id_out),
	.mem_r_en_in	(mem_r_en_id_out),
	.mem_w_en_in	(mem_w_en_id_out),
	.b_in	(b_id_out),
	.s_in	(s_id_out),
	.exe_cmd_in	(exec_cmd_id_out),
	.pc_in	(pc_id_out),
	.val_rn_in	(val_rn_id_out),
	.val_rm_in	(val_rm_id_out),
	.imm_in	(imm_id_out),
	.shift_operand_in	(shift_operand_id_out),
	.signed_imm_24_in	(signed_imm_24_id_out),
	.dest_in	(dest_id_out),
	.sr_in	(sr),
	.src1_in	(src1_id_out),
	.src2_in	(src2_id_out),
	.wb_en	(wb_en_id_reg_out),
	.mem_r_en	(mem_r_en_id_reg_out),
	.mem_w_en	(mem_w_en_id_reg_out),
	.b (branch_taken),
	.s (s_id_reg_out),
	.exe_cmd	(exe_cmd_id_reg_out),
	.pc	(pc_id_reg_out),
	.val_rn	(val_rn_id_reg_out),
	.val_rm	(val_rm_id_reg_out),
	.imm	(imm_id_reg_out),
	.shift_operand	(shift_operand_id_reg_out),
	.signed_imm_24	(signed_imm_24_id_reg_out),
	.dest	(dest_id_reg_out),
	.sr_out	(sr_id_reg_out),
	.src1_out	(src1_id_reg_out),
	.src2_out	(src2_id_reg_out)
);

wire [1:0] sel_src_1;
wire [1:0] sel_src_2;
wire [31:0] alu_result_exe_reg_out;
wire [31:0] alu_result_exe_out;
wire [31:0] val_rm_exe_out;

execution exe(
	.clk	(clk),
	.rst 	(rst),
	.s	(s_id_reg_out),
	.exec_cmd	(exe_cmd_id_reg_out),
	.mem_r_en	(mem_r_en_id_reg_out),
	.mem_w_en	(mem_w_en_id_reg_out),
	.pc	(pc_id_reg_out),
	.val_rn	(val_rn_id_reg_out),
	.val_rm	(val_rm_id_reg_out),
	.imm	(imm_id_reg_out),
	.shift_operand	(shift_operand_id_reg_out),
	.signed_imm_24	(signed_imm_24_id_reg_out),
	.sr	(sr_id_reg_out),
	.sel_src_1	(sel_src_1),
	.sel_src_2	(sel_src_2),
	.alu_result_in	(alu_result_exe_reg_out),
	.dest_in	(dest_wb),
	.alu_result	(alu_result_exe_out),
	.br_addr	(branch_adr),
	.status	(sr),
	.val_rm_out	(val_rm_exe_out)
);


wire wb_en_exe_reg_out;
wire mem_r_en_exe_reg_out;
wire mem_w_en_exe_reg_out;
wire [3:0] dest_exe_reg_out;
wire [31:0] val_rm_exe_reg_out;

execution_register exe_reg(
	.clk	(clk),
	.rst	(rst),
	.wb_en_in	(wb_en_id_reg_out),
	.mem_r_en_in	(mem_r_en_id_reg_out),
	.mem_w_en_in	(mem_w_en_id_reg_out),
	.alu_result_in	(alu_result_exe_out),
	.st_val_in	(val_rm_exe_out),
	.dest_in	(dest_id_reg_out),
	.wb_en	(wb_en_exe_reg_out),
	.mem_r_en	(mem_r_en_exe_reg_out),
	.mem_w_en	(mem_w_en_exe_reg_out),
	.alu_result	(alu_result_exe_reg_out),
	.st_val	(val_rm_exe_reg_out),
	.dest	(dest_exe_reg_out)
);

wire [31:0] mem_result_out;
wire [31:0] mem1024,mem1028,mem1032,mem1036,mem1040,mem1044,mem1048;
data_memory memory(
	.clk	(clk),
	.rst	(rst),
	.mem_read	(mem_r_en_exe_reg_out),
	.mem_write	(mem_w_en_exe_reg_out),
	.data	(val_rm_exe_reg_out),
	.address	(alu_result_exe_reg_out),
	.mem1024(mem1024),
	.mem1028(mem1028),
	.mem1032(mem1032),
	.mem1036(mem1036),
	.mem1040(mem1040),
	.mem1044(mem1044),
	.mem1048(mem1048),
	.mem_result	(mem_result_out)
);

wire [31:0] alu_result_mem_reg_out;
wire [31:0] mem_read_val_mem_reg_out;
wire mem_r_en_mem_reg_out;

memory_register mem_reg(
	.clk	(clk),
	.rst	(rst),
	.wb_en_in	(wb_en_exe_reg_out),
	.mem_r_en_in	(mem_r_en_exe_reg_out),
	.alu_result_in	(alu_result_exe_reg_out),
	.mem_read_value_in	(mem_result_out),
	.dest_in	(dest_exe_reg_out),
	.alu_result	(alu_result_mem_reg_out),
	.mem_read_value	(mem_read_val_mem_reg_out),
	.dest	(dest_wb),
	.wb_en	(write_back_enable),
	.mem_r_en	(mem_r_en_mem_reg_out)
);

write_back wb(
	.alu_result	(alu_result_mem_reg_out),
	.mem_result	(mem_read_val_mem_reg_out),
	.mem_r_en	(mem_r_en_mem_reg_out),
	.out	(result_wb)
);

hazard_detection_unit_old hdu(
	.src1	(src1_id_out),
	.src2	(src2_id_out),
	.exe_dest	(dest_id_reg_out),
	.exe_wb_en	(wb_en_id_reg_out),
	.mem_wb_en	(wb_en_exe_reg_out),
	.two_src	(two_src_id_out),
	.mem_dest	(dest_exe_reg_out),
	.hazard_detected	(hazard)
);


forwarding_unit fu(
	.src1	(src1_id_reg_out),
	.src2 	(src2_id_reg_out),
	.wb_wb_en	(write_back_enable),
	.wb_dest	(dest_wb),
	.mem_wb_en	(write_back_enable),
	.mem_dest	(dest_wb),
	.forwarding_enabled	(forwarding_enabled),
	.sel_src_1	(sel_src_1),
	.sel_src_2	(sel_src_2)
);


endmodule // ARM