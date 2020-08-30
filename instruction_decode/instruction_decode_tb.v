`timescale 1ns/1ns

module instruction_decode_tb;

    
    reg clk;
    reg rst;
    reg [31:0] instruction;
    reg [31:0] result_wb;
    reg write_back_enable;
    reg [3:0] dest_wb;
    reg hazard;
    reg [3:0] sr;
    reg [31:0] pc_in;

    wire wb_en;
    wire mem_r_en;
    wire mem_w_en;
    wire b;
    wire s;
    wire [3:0] exec_cmd;
    wire [31:0] val_rn;
    wire [31:0] val_rm;
    wire imm;
    wire [11:0] shift_operand;
    wire [23:0] signed_imm_24;
    wire [3:0] dest;
    wire [3:0] src1;
    wire [3:0] src2;
    wire two_src;
    wire [31:0] pc_out;

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
    wire [31:0] R1,R2,R3,R4,R5,R6,R7,R0,R8,R9,R10,R11;
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
    initial begin
        instruction = 32'b0000_00_0_0100_0_0010_0010_000000000010;
        result_wb = 32'b11100011101000000000000000011111;
        write_back_enable = 1;
        dest_wb = 4'b0000;
        rst = 1;
        hazard = 0;
        sr = 4'b1000;
        clk=0;
        pc_in = 32'b11100011101000000000000111111111;

        #1ns
        clk = ~clk;     
        #1ns
        clk = ~clk;  
        #1ns
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

endmodule