module instrcution_decode(
    input clk,
    input rst,
    input [31:0] instruction,
    input [31:0] result_wb,
    input write_back_enable,
    input [3:0] dest_wb,
    input hazard,
    input [3:0] sr,
    input [31:0] pc_in,
    input [31:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,
    output wb_en,
    output mem_r_en,
    output mem_w_en,
    output b,
    output s,
    output [3:0] exec_cmd,
    output [31:0] val_rn,
    output [31:0] val_rm,
    output imm,
    output [11:0] shift_operand,
    output [23:0] signed_imm_24,
    output [3:0] dest,
    output [3:0] src1,
    output [3:0] src2,
    output two_src,
    output [31:0] pc_out
);

assign shift_operand = instruction[11:0];
assign imm = instruction[25];
assign signed_imm_24 = instruction[23:0];
assign pc_out = pc_in;
assign two_src = !instruction[25] || mem_w_en;
assign dest = instruction[15:12];

wire check;

wire[3:0] exec_cmd_wire;
wire mem_r_en_wire;
wire mem_w_en_wire;
wire wb_en_wire;
wire b_wire;
wire s_wire;

control_unit cu(
    .mode   (instruction[27:26]),
    .opcode (instruction[24:21]),
    .s  (instruction[20]),
    .execute_command    (exec_cmd_wire),
    .mem_read   (mem_r_en_wire),
    .mem_write  (mem_w_en_wire),
    .wb_enable  (wb_en_wire),
    .b  (b_wire),
    .update_state   (s_wire)
);

condition_check cc(
    .condition  (instruction[31:28]),
    .condState  (sr),
    .check  (check)
);

wire cond_or_hazard;

assign cond_or_hazard = hazard || !check;
assign s = !cond_or_hazard ? s_wire : 0;
assign b = !cond_or_hazard ? b_wire : 0;
assign wb_en = !cond_or_hazard ? wb_en_wire : 0;
assign mem_w_en = !cond_or_hazard ? mem_w_en_wire : 0;
assign mem_r_en = !cond_or_hazard ? mem_r_en_wire : 0;
wire [3:0] src2_wire;
assign exec_cmd = !cond_or_hazard ? exec_cmd_wire : 0;
assign src1 = instruction[19:16];
assign src2 = src2_wire;

assign src2_wire = mem_w_en ? dest : instruction[3:0];

register_file rf(
    .clk   (clk),
    .rst   (rst),
    .src1  (instruction[19:16]),
    .src2  (src2_wire),
    .dest_wb   (dest_wb),
    .result_wb (result_wb),
    .write_back_enable (write_back_enable),
    .reg1  (val_rn),
    .reg2  (val_rm),
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
    .R11(R11)
);


endmodule // instrcution_decode