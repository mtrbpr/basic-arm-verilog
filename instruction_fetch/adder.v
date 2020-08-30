module adder(
    input [31:0] a,
    input [31:0] b,
    input rst,
    output [31:0] result
);

assign result = rst ? 32'b0: a+b;

endmodule // aluinput [31:0] a,
