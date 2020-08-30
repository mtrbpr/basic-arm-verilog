module write_back(
    input [31:0] alu_result,
    input [31:0] mem_result,
    input mem_r_en,
    output [31:0] out
);

assign out = mem_r_en ? mem_result : alu_result;

endmodule // write_back