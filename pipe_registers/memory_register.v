module memory_register(
    input clk,
    input rst,
    input wb_en_in,
    input mem_r_en_in,
    input [31:0] alu_result_in,
    input [31:0] mem_read_value_in,
    input [3:0] dest_in,
    output reg [31:0] alu_result,
    output reg [31:0] mem_read_value,
    output reg [3:0] dest,
    output reg wb_en,
    output reg mem_r_en
);

always @(posedge clk, posedge rst) begin
    if (rst) begin
        alu_result <= 0;
        mem_read_value <= 0;
        dest <= 0;
        wb_en <= 0;
        mem_r_en <= 0;
    end else begin
        dest <= dest_in;
        mem_read_value <= mem_read_value_in;
        alu_result <= alu_result_in;
        wb_en <= wb_en_in;
        mem_r_en <= mem_r_en_in;
    end
end

endmodule // memory_register    