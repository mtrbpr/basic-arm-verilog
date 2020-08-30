module control_unit (
  input [1:0] mode,
  input [3:0] opcode,
  input s,
  output [3:0] execute_command,
  output mem_read, mem_write,
  output wb_enable,
  output b,
  output update_state
);

  assign update_state = s;
  assign b = (opcode[3] == 1'b0 && mode == 2'b10) ? 1'b1 : 1'b0;
  assign wb_enable = (opcode == 4'b1101 || opcode == 4'b1111 || (opcode == 4'b0100 && mode == 2'b00) || opcode == 4'b0101 || opcode == 4'b0010 || opcode == 4'b0110 || opcode == 4'b0000 || opcode == 4'b1100 || opcode == 4'b0001 || (opcode == 4'b0100 && s == 1'b1 && mode == 2'b01)) ? 1'b1 : 0;
  assign mem_read = (opcode == 4'b0100 && mode == 2'b01 && s == 1'b1 ) ? 1 : 0;
  assign mem_write = (opcode == 4'b0100 && mode == 2'b01 && s == 1'b0 ) ? 1 : 0;
  assign execute_command = (opcode == 4'b1101 ? 4'b0001 : (opcode == 4'b1111 ? 4'b1001 : (opcode == 4'b0100 ? 4'b0010 :
   (opcode == 4'b0101 ? 4'b0011 : (opcode == 4'b0010 ? 4'b0100 : (opcode == 4'b0110 ?  4'b0101 : (opcode == 4'b0000 ? 4'b0110 : (opcode == 4'b1100 ? 4'b0111 :
   (opcode == 4'b0001 ? 4'b1000 : (opcode == 4'b1010 ? 4'b0100 : (opcode == 4'b1101 ? 4'b0110 : (opcode == 4'b1000 ? 4'b0110 : 4'b0))))))))))));

endmodule