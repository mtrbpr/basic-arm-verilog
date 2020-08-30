module instruction_decode_register(
    input clk,
    input rst,
    input flush,
    input wb_en_in,
    input mem_r_en_in,
    input mem_w_en_in,
    input b_in,
    input s_in,
    input [3:0] exe_cmd_in,
    input [31:0] pc_in,
    input [31:0] val_rn_in,
    input [31:0] val_rm_in,
    input imm_in,
    input [11:0] shift_operand_in,
    input [23:0] signed_imm_24_in,
    input [3:0] dest_in,
    input [3:0] sr_in,
    input [3:0] src1_in,
    input [3:0] src2_in,
    output reg wb_en,
    output reg mem_r_en,
    output reg mem_w_en,
    output reg b,
    output reg s,
    output reg [3:0] exe_cmd,
    output reg [31:0] pc,
    output reg [31:0] val_rn,
    output reg [31:0] val_rm,
    output reg imm,
    output reg [11:0] shift_operand,
    output reg [23:0] signed_imm_24,
    output reg [3:0] dest,
    output reg [3:0] sr_out,
    output reg [3:0] src1_out,
    output reg [3:0] src2_out
);

always@(posedge clk, posedge rst) begin
    if (rst || flush) begin
        wb_en <= 0;
        mem_r_en <= 0;
        mem_w_en <= 0;
        b <= 0;
        s <= 0;
        exe_cmd <= 0;
        pc <= 0;
        val_rm <= 0;
        val_rn <= 0;
        imm <= 0;
        shift_operand <= 0;
        signed_imm_24 <= 0;
        dest <= 0;
        src1_out <= 0;
        src2_out <= 0;
        sr_out <= 0;
    end else begin
        wb_en <= wb_en_in;
        mem_r_en <= mem_r_en_in;
        mem_w_en <= mem_w_en_in;
        b <= b_in;
        s <= s_in;
        exe_cmd <= exe_cmd_in;
        pc <= pc_in;
        val_rm <= val_rm_in;
        val_rn <= val_rn_in;
        imm <= imm_in;
        shift_operand <= shift_operand_in;
        signed_imm_24 <= signed_imm_24_in;
        dest <= dest_in;
        src1_out <= src1_in;
        src2_out <= src2_in;
        sr_out <= sr_in;
    end
end

endmodule // instruction_decode_register