module ov_detector(input pre_ov, comp_res, input [31:0]  num1, num2, sum, output out_ov);
    wire pipe_ov;
    assign pipe_ov = (num1[31] & num2[31] & ~sum[31]) | (~num1[31] & ~num2[31] & sum[31]);
    assign out_ov = (comp_res == 1) ? pre_ov : (pre_ov | pipe_ov);
endmodule