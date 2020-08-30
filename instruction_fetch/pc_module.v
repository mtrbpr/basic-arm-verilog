module pc_module(
    input [31:0] pc_in,
    input freeze,
    input clk,
    input rst,
    output reg [31:0] pc_out
);


always @(posedge clk,rst) begin
    if (rst == 1) begin
        pc_out <= 0;
    end
    else if(freeze == 1) begin
        pc_out <= pc_out;
    end
    else begin
        pc_out <= pc_in;
    end
end

endmodule 