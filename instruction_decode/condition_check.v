module condition_check (
    input[3:0] condition,
    input[3:0] condState,
    output check
);


 /*   wire v, c, z, n;
    assign v = condState[0];
    assign c = condState[1];
    assign z = condState[2];
    assign n = condState[3];
    */

    assign check = ((condition == 4'b0000 && condState[2] == 1'b1) || (condition == 4'b0001 && condState[2] == 1'b0) || (condition == 4'b0010 && condState[1] == 1'b1)
    || (condition == 4'b0011 && condState[1] == 1'b0) || (condition == 4'b0100 && condState[3] == 1'b1) || (condition == 4'b0101 && condState[3] == 1'b0) 
    || (condition == 4'b0110 && condState[0] == 1'b1) || (condition == 4'b0111 && condState[0] == 1'b0) || (condition == 4'b1000 && condState[1] == 1'b1 && condState[2] == 1'b0)
    || (condition == 4'b1001 && (condState[1] == 1'b0 || condState[2] == 1'b1)) || (condition == 4'b1010 && condState[3] == condState[0]) || (condition == 4'b1011 && condState[3] != condState[0]) 
    || (condition == 4'b1100 && condState[2] == 1'b0 && condState[3] == condState[0]) || (condition == 4'b1101 && (condState[2] == 1'b1 || condState[3] != condState[0])) || (condition == 4'b1110) || (condition == 4'b1111)) ? 1'b1 : 1'b0;

    /*
    always@(*) begin
        if (condition == 4'b0000 && z == 1'b1) begin
            check <= 1'b1;
        end
        else if (condition == 4'b0001 && z == 1'b0) begin
            check<= 1'b1;
        end
        else if (condition == 4'b0010 && c == 1'b1) begin
            check<= 1'b1;
        end
        else if (condition == 4'b0011 && c == 1'b0) begin
            check<= 1'b1;
        end
        else if (condition == 4'b0100 && n == 1'b1) begin
            check<= 1'b1;
        end
        else if (condition == 4'b0101 && n == 1'b0) begin
            check<= 1'b1;
        end
        else if (condition == 4'b0110 && v == 1'b1) begin
            check<= 1'b1;
        end
        else if (condition == 4'b0111 && v == 1'b0) begin
            check<= 1'b1;
        end
        else if (condition == 4'b1000 && c == 1'b1 && z == 1'b0) begin
            check<= 1'b1;
        end
        else if (condition == 4'b1001 && c == 1'b0 || z == 1'b1) begin
            check<= 1'b1;
        end
        else if (condition == 4'b1010 && n == v) begin
            check<= 1'b1;
        end
        else if (condition == 4'b1011 && n != v) begin
            check<= 1'b1;
        end
        else if (condition == 4'b1100 && z == 1'b0 && n == v) begin
            check<= 1'b1;
        end
        else if (condition == 4'b1101 && z == 1'b1 || n != v) begin
            check<= 1'b1;
        end
        else if (condition == 4'b1110) begin
            check<= 1'b1;
        end
        else if (condition == 4'b1111) begin
            check<= 1'b1;
        end
        else begin
            check<= 1'b0;
        end
    end
    */

endmodule
