module initial_part(input [7:0] X, input [31:0] pre_X, pre_X_power, pre_sum, input pre_ov, sel,
                    output [31:0] next_X, next_X_power, next_sum, output next_ov);
    wire [31:0] extend_X;
    zero_extend ze(.X(X), .out_X(extend_X));
    mux #(32) mux1(.num1(extend_X), .num2(pre_X), .sel(sel), .out_mux(next_X));
    mux #(32) mux2(.num1(32'b01111111111111111111111111111111), .num2(pre_X_power), .sel(sel), .out_mux(next_X_power));
    mux #(32) mux3(.num1(32'b0), .num2(pre_sum), .sel(sel), .out_mux(next_sum));
    mux #(1) mux4(.num1(1'b0), .num2(pre_ov), .sel(sel), .out_mux(next_ov));
endmodule