module instruction_fetch_register(
    input clk,
    input rst,
    input freeze,
    input flush,
    input [31:0] pc_in,
    input [31:0] instruction_in,
    output reg [31:0] pc,
    output reg [31:0] instruction
);

always@(posedge clk, posedge rst) begin
    if(rst || flush) begin
        pc <= 32'b0;
        instruction <= 32'b0;			
    end
    else if(freeze == 1'b0) begin
        pc <= pc_in;
        instruction <= instruction_in;
    end else begin
        pc <= pc;
        instruction <= instruction;
    end
end

endmodule // instruction_fetch_register