`timescale 1ns/1ns
module alu_tb(
    
);

    reg[3:0] exec_command;
    reg[31:0] in1;
    reg[31:0] in2;
    reg carry_in;
    wire[31:0] result;
    wire c;
    wire n;
    wire z;
    wire v;


    wire [32:0] result_extend;
    wire [32:0] in1_extend;
    wire [32:0] in2_extend;

    assign in1_extend = {in1[31],in1};
    assign in2_extend = {in2[31],in2};

    assign result_extend = exec_command == 4'b0001 ? in2_extend : (exec_command == 4'b1001 ? ~in2_extend : (exec_command == 4'b0010 ? (in2_extend + in1_extend) : 
    (exec_command == 4'b0011 ? (in1_extend + in2_extend + carry_in) : (exec_command == 4'b0100 ? (in1_extend - in2_extend) : (exec_command == 4'b0101 ? (in1_extend - in2_extend - 1) : 
    (exec_command == 4'b0110 ? (in1_extend & in1_extend) : (exec_command == 4'b0111 ? (in1_extend | in2_extend) : (exec_command == 4'b1000 ? (in2_extend ^ in1_extend) : 
    (in1_extend))))))))) ;

    assign result = result_extend[31:0];

    assign c = result_extend[32] == 1'b1 && result_extend[31] == 1'b0;
    assign n = result[31];
    assign z = (result == 0);
    assign v = ((exec_command == 4'b0010 || exec_command == 4'b0011) && in1[31] == in2[31] && in1[31] != result[31]) || ((exec_command == 4'b0100 || exec_command == 4'b0101) && in1[31] == ~in2[31] && in1[31] != result[31]);
    
    initial begin
        exec_command = 4'b0100;
        in1 = 1;
        in2 = 3;
        carry_in = 1'b1;
    end

    initial begin
        $dumpvars(0);
        #10000ns
        $finish;
    end

endmodule // alu_tb

//-1073741824