`timescale 1ns/1ns

module data_memory_tb;

    reg clk;
	reg rst;
	reg mem_read;
	reg mem_write;
	reg [31:0] data;
	reg [31:0] address;
	reg [31:0] mem_result;

	wire [31:0] index;
	assign index = address - 1024 - address[1:0];
	reg [7:0] memory [0:255];
	reg [8:0] counter;

	always @(mem_read, address, memory[address]) begin
		if(mem_read) begin
            mem_result <= {memory[index],memory[index+1],memory[index+2],memory[index+3]};
        end
	end

	always @(posedge clk, posedge rst) begin
		if (rst) begin
			for (counter = 0 ; counter < 256 ; counter = counter +1 ) begin
				memory[counter] <= 0;
			end
		end
		else if (mem_write) begin 
			memory[index] <= data[31:24];
			memory[index + 1] <= data[23:16];
			memory[index + 2] <= data[15:8];
			memory[index + 3] <= data[7:0];
		end
	end
    wire [31:0] dataWire;
    assign dataWire = {memory[0],memory[0+1],memory[0+2],memory[0+3]};

    initial begin
        clk = 0;
        rst = 1;
        mem_read = 1'b0;
        mem_write = 1'b1;
        data = 85;
        address  = 1024;
        #2ns
        rst = 0;
        
        repeat (5) begin
            #1ns
            clk = !clk;
        end
        $display("%b",dataWire);
        mem_read = 1'b1;
        mem_write = 1'b0;
        repeat (5) begin
            #1ns
            clk = !clk;
        end
    end

    initial begin
        $dumpvars(0);
        #10000ns
        $finish;
    end

endmodule // data_memory_tb