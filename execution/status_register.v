module status_register(
    input clk,
    input rst,
    input n,
    input z,
    input c,
    input v,
    input s,
    output [3:0] cond
);

reg[3:0] cond_reg;

always @(negedge clk, rst) begin
    if(rst == 1'b1) begin
        cond_reg <= 4'b0;
    end else if (s == 1'b1) begin
        cond_reg <= {n,z,c,v};
    end
end

assign cond = rst == 1'b1 ? 4'b0 : cond_reg;

endmodule