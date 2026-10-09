module shift_right_reg(input clk, rst, ld , shift_r, input [31:0] parLoad, output reg [31:0] dataOut);
    reg [31:0] data;
    always@(posedge clk or posedge rst)begin
        if(rst == 1'b1)
            data <= 16'b0;
        else if(ld == 1'b1)
            data <= parLoad;
        else
            if(shift_r == 1'b1)
                data <= {1'b0, data[31:1]};
            else
                data <= data;
    end
    assign dataOut = data;
endmodule