module mux32(
    input [31:0] src1,
    input [31:0] src2,
    input [31:0] src3,
    input [1:0] select,
    output [31:0] out
);

assign out = (select == 2'b00) ? src1 : 
             (select == 2'b01) ? src2 :
             (select == 2'b10) ? src3 :
             32'b0;

endmodule // mux32
