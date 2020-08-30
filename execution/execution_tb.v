`timescale 1ns/1ns

module execution_tb;

    reg clk;
    reg rst;
    reg s;
    reg [3:0] exec_cmd;
    reg mem_r_en, mem_w_en;
    reg [31:0] pc;
    reg [31:0] val_rn,val_rm;
    reg imm;
    reg [11:0] shift_operand;
    reg [23:0] signed_imm_24;
    reg [3:0] sr;
    reg [1:0] sel_src_1;
    reg [1:0] sel_src_2;
    reg [31:0] alu_result_in;
    reg [3:0] dest_in;

    reg [31:0] instruction;

    wire[31:0] alu_result,br_addr;
    wire[3:0] status;
    wire[31:0] val_rm_out;

    wire [31:0] dest_in_sign_extend ;
    assign dest_in_sign_extend = dest_in;
    wire[31:0] signed_imm_24_extended;
    assign signed_imm_24_extended = {signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24[23],signed_imm_24};
    assign br_addr = pc + (signed_imm_24_extended << 2) + 4;
    wire mem_en;
    wire c,n,z,v;
    assign mem_en = mem_r_en || mem_w_en;
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
        .rst    (rst),
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

    initial begin

        
        instruction = 32'b10111010111111111111111111110111;
        clk = 0;
        s = instruction[20];
        exec_cmd = 4'b0100;
        mem_r_en = 1'b0;
        mem_w_en = 1'b0;
        pc = 1000;
        val_rn = 1;
        val_rm = 85;
        imm = instruction[25];
        shift_operand = instruction[11:0];
        signed_imm_24 = instruction[23:0];
        sr = 4'b0000;
        sel_src_1 = 2'b0;
        sel_src_2 = 2'b0;
        alu_result_in = 53;
        dest_in = instruction[15:12];

        rst = 1;
        #2ns
        rst = 0;
        repeat(1000) begin
            #1ns 
            clk=~clk;
        end
    end
    

    initial begin
        $dumpvars(0);
        #10000ns
        $finish;
    end

endmodule // execution_tb