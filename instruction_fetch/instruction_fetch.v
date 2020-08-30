module instruction_fetch(
    input clk,
    input rst,
    input freeze,
    input branch_taken,
    input [31:0] branch_adr,
    output [31:0] pc_out,
    output [31:0] instruction 
);

wire [31:0] pc_wire;
wire [31:0] mux_out;
wire [31:0] pc_out_wire;

pc_module pcm(.pc_in    (mux_out),.freeze   (freeze),.clk   (clk),.rst  (rst),.pc_out   (pc_wire));
multiplexer mux(.a  (pc_out_wire),.b    (branch_adr),.select    (branch_taken),.out     (mux_out));
adder adder(.a     (pc_wire),.b    (4), .rst     (rst), .result    (pc_out_wire));
instruction_memory memory(.addr     (pc_wire), .rst     (rst) ,.instruction      (instruction));
assign pc_out = rst ? 32'b0 : pc_out_wire;
endmodule 