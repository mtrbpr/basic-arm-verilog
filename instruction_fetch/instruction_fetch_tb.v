`timescale 1ns/1ns

module instruction_fetch_tb;

reg clk;
reg rst;
reg freeze;
reg branch_taken;
reg [31:0] branch_adr;
wire [31:0] pc_out;
wire [31:0] instruction; 


initial begin 
    rst = 1;
    freeze = 0;
    branch_adr = 0;
	clk=0;
	branch_taken = 0;
	#1ns
	clk = ~clk;     
    #1ns
	clk = ~clk;  
     

    #1ns
    rst = 0;
    clk = ~clk;
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk;     
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
    #1ns
	clk = ~clk; 
end

instruction_fetch if_stage(
    .clk(clk),
    .rst(rst),
    .freeze(freeze),
    .branch_taken(branch_taken),
    .branch_adr(branch_adr),
    .pc_out(pc_out),
    .instruction(instruction) 
);

initial begin
	$dumpvars(0);
	#10000ns
	$finish;
end

endmodule // multiplextbinitial begin
