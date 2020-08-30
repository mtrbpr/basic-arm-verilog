`timescale 1ns/1ns

module multiplexer_tb;
reg[31:0] a;
reg[31:0] b;
reg sel;
wire[31:0] out;

//multiplexer mux(.a(a),.b(b),.select(sel),.out(out));
initial begin
	a = 3;
    b = 4;
    sel = 0; 
end
initial begin 
	sel=0;
	forever begin
	       #5ns
		sel = ~sel;       
	end
end

multiplexer mux(.a(a),.b(b),.select(sel),.out(out));

initial begin
	$dumpvars(0);
	#10000ns
	$finish;
end

endmodule // multiplextbinitial begin
