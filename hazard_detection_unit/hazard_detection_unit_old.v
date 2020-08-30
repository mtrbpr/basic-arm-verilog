module hazard_detection_unit_old(
    input [3:0] src1,
    input [3:0] src2,
    input [3:0] exe_dest,
    input exe_wb_en,
    input mem_wb_en,
    input two_src,
    input [3:0] mem_dest,
    output reg hazard_detected
);

always @(*) begin
    if(mem_wb_en && src1 == mem_dest) begin
        hazard_detected <= 1;
    end else if(exe_wb_en && src1 == exe_dest) begin
        hazard_detected <= 1;
    end else if(two_src && mem_wb_en && src2 == mem_dest) begin
        hazard_detected <= 1;
    end else if(two_src && exe_wb_en && src2 == exe_dest) begin
        hazard_detected <= 1;
    end else begin
        hazard_detected <= 0;
    end
end

endmodule // hazard_detection_unit