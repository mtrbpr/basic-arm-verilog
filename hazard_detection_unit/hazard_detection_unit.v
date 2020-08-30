module hazard_detection_unit(
    input [3:0] src1,
    input [3:0] src2,
    input [3:0] exe_dest,
    input exe_mem_r_en,
    input two_src,
    output reg hazard_detected
);


always @(*) begin
    if(exe_mem_r_en && src1 == exe_dest) begin
        hazard_detected <= 1;
    end else if(exe_mem_r_en && src1 == exe_dest) begin
        hazard_detected <= 1;
    end else if(two_src && exe_mem_r_en && src2 == exe_dest) begin
        hazard_detected <= 1;
    end else if(two_src && exe_mem_r_en && src2 == exe_dest) begin
        hazard_detected <= 1;
    end else begin
        hazard_detected <= 0;
    end
end

endmodule // hazard_detection_unit