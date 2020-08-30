module forwarding_unit(
    input [3:0] src1,
    input [3:0] src2,
    input wb_wb_en,
    input [3:0] wb_dest,
    input mem_wb_en,
    input [3:0] mem_dest,
    input forwarding_enabled,
    output reg [1:0] sel_src_1,
    output reg [1:0] sel_src_2
);

always @(*) begin
    if(!forwarding_enabled) begin
        sel_src_1 <= 0;
        sel_src_2 <= 0;    
    end
    else if (wb_wb_en && src1 == wb_dest) begin
        sel_src_1 <= 2;
    end else if (wb_wb_en && src2 == wb_dest) begin
        sel_src_2 <= 2;
    end else if (mem_wb_en && src1 == mem_dest) begin
        sel_src_1 <= 1;
    end else if (mem_wb_en && src2 == mem_dest) begin
        sel_src_2 <= 1;
    end else begin
        sel_src_1 <= 0;
        sel_src_2 <= 0;
    end

end

endmodule // forwarding_unit