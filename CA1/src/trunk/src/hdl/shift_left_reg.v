module shift_left_reg(input clk, rst, ld , shift_l, input [15:0] parLoad, output reg cout, output reg [15:0] dataOut);
    reg [15:0] data;
    always@(posedge clk or posedge rst)begin
        if(rst == 1'b1)
            data <= 16'b0;
        else if(ld == 1'b1)
            data <= parLoad;
        else
            if(shift_l == 1'b1) begin
                if(data[15] == 1'b1)
                    cout <= 1'b1;
                else
                    cout <= 1'b0;
                data <= {data[14:0],1'b0};
            end
            else begin
                data <= data;
            end
    end
    assign dataOut = data;
endmodule