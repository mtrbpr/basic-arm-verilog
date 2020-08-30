module multiplexer(
    input [31:0] a,
    input [31:0] b,
    input select,
    output [31:0] out
);
assign out = select ? b : a;

endmodule // multiplexer[31,0] 
 