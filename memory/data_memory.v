module data_memory(
	input clk,
	input rst,
	input mem_read,
	input mem_write,
	input [31:0] data,
	input [31:0] address,
	output [31:0] mem1024,mem1028,mem1032,mem1036,mem1040,mem1044,mem1048,
	output [31:0] mem_result
);
	wire [31:0] index;
	assign index = address - 1024 - address[1:0];
	reg [7:0] memory [0:255];
	reg [8:0] counter;
	
	assign mem1024 = {memory[0],memory[0+1],memory[0+2],memory[0+3]};
	assign mem1028 = {memory[4],memory[4+1],memory[4+2],memory[4+3]};
	assign mem1032 = {memory[8],memory[8+1],memory[8+2],memory[8+3]};
	assign mem1036 = {memory[12],memory[12+1],memory[12+2],memory[12+3]};
	assign mem1040 = {memory[16],memory[16+1],memory[16+2],memory[16+3]};
	assign mem1044 = {memory[20],memory[20+1],memory[20+2],memory[20+3]};
	assign mem1048 = {memory[24],memory[24+1],memory[24+2],memory[24+3]};
	
	assign mem_result = mem_read ? {memory[index],memory[index+1],memory[index+2],memory[index+3]} : 32'b0;

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

endmodule