module execution(
    input clk,
    input rst,
    input s,
    input [3:0] exec_cmd,
    input mem_r_en, mem_w_en,
    input [31:0] pc,
    input [31:0] val_rn,val_rm,
    input imm,
    input [11:0] shift_operand,
    input [23:0] signed_imm_24,
    input [3:0] sr,
    input [1:0] sel_src_1,
    input [1:0] sel_src_2,
    input [31:0] alu_result_in,
    input [3:0] dest_in,
    output[31:0] alu_result,br_addr,
    output[3:0] status,
    output[31:0] val_rm_out
);

wire [31:0] dest_in_sign_extend ;
assign dest_in_sign_extend = dest_in;
wire[31:0] signed_imm_24_extended;
assign signed_imm_24_extended = {signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24};
assign br_addr = pc + (signed_imm_24_extended << 2);
wire mem_en;
wire c,n,z,v;
assign mem_en = mem_r_en | mem_w_en;
wire [31:0] mux_before_alu_out_wire;

wire[31:0] val2_gen_wire;
 
val2_gen val2_gen(
    .val_rm (val_rm_out),
    .imm    (imm),
    .mem_en (mem_en),
    .shift_operand  (shift_operand),
    .result (val2_gen_wire)
);


alu alu(
    .exec_command (exec_cmd),
    .in1    (mux_before_alu_out_wire),
    .in2    (val2_gen_wire),
    .carry_in   (sr[1]),
    .result (alu_result),
    .c  (c),
    .n  (n),
    .z  (z),
    .v  (v)
);


status_register sreg(
    .clk   (clk),
    .rst   (rst),
    .n (n),
    .z (z),
    .c (c),
    .v (v),
    .s (s),
    .cond  (status)
);

mux32 mux_before_val2(
    .src1 (val_rm),
    .src2 (alu_result_in),
    .src3 (dest_in_sign_extend),
    .select   (sel_src_2),
    .out  (val_rm_out)
);

mux32 mux_before_alu(
    .src1 (val_rn),
    .src2 (alu_result_in),
    .src3 (dest_in_sign_extend),
    .select   (sel_src_1),
    .out  (mux_before_alu_out_wire)
);

endmodule 