`timescale 1ns/1ns

module val2_gen_tb;

    reg[31:0] val_rm;
    reg imm;
    reg mem_en;
    reg [11:0] shift_operand;
    reg [31:0] result;
    reg[31:0] counter;
    
    always @(*) begin
        if(mem_en == 1) begin
        result = shift_operand; 
        end
        else if (imm == 1) begin
            result = shift_operand[7:0];
            for (counter = 0; counter < (shift_operand[11:8] << 1); counter = counter + 1 ) begin
                $display("%b",result);
                result = {result[0],result[31:1]} ;
            end
            $display("%b",result);
        end else if(imm == 0 && shift_operand[4] == 0) begin
            case (shift_operand[6:5])
                4'b00: result <= val_rm << shift_operand[11:7];
                4'b01: result <= val_rm >> shift_operand[11:7];
                4'b10: result <= val_rm >>> shift_operand[11:7];
                4'b11:
                begin
                    result = val_rm;
                    for (counter = 1; counter < shift_operand[11:7]; counter = counter + 1 ) begin
                        result = {result[0],result[31:1]} ;
                    end
                end
                default: result <= val_rm;
            endcase
        end else begin
            result <= val_rm;
        end
    end

    initial begin
        val_rm = 33;
        imm = 1'b1;
        mem_en = 1'b0;
        shift_operand = 12'b000100000011;
    end

    initial begin
        $dumpvars(0);
        #10ns
        $finish;
    end
endmodule 