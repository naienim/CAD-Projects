module datapath(input clk, rst, sel, input [7:0] X, input [2:0] N, output ov, err, output [31:0] Y);
    wire [31:0] next_x, next_x_power, next_sum;
    wire [31:0] x_out_pipe1, power_out_pipe1, sum_out_pipe1;
    wire [31:0] x_out_pipe2, power_out_pipe2, sum_out_pipe2;
    wire [31:0] x_out_pipe3, power_out_pipe3, sum_out_pipe3;
    wire [31:0] x_out_pipe4, power_out_pipe4, sum_out_pipe4;
    wire next_ov, ov_out_pipe1, ov_out_pipe2, ov_out_pipe3, ov_out_pipe4;
    wire sel_out_pipe1, sel_out_pipe2, sel_out_pipe3, sel_out_pipe4;

    wire [31:0] const1 = 32'b01111111111111111111111111111111;           // 1
    wire [31:0] const2 = 32'b11000000000000000000000000000000;           // -1/2
    wire [31:0] const3 = 32'b00101010101010101010101010101010;           // 1/3
    wire [31:0] const4 = 32'b11100000000000000000000000000000;           // -1/4
    wire [31:0] const5 = 32'b00011001100110011001100110011001;           // 1/5
    wire [31:0] const6 = 32'b11101010101010101010101010101011;           // -1/6
    wire [31:0] const7 = 32'b00010010010010010010010010010010;           // 1/7
    wire [31:0] const8 = 32'b11110000000000000000000000000000;           // -1/8


    initial_part init(X, x_out_pipe4, power_out_pipe4, sum_out_pipe4, ov_out_pipe4, sel, 
                      next_x, next_x_power, next_sum, next_ov);

    pipe pp1(clk, rst, sel, next_ov, next_x, next_x_power, next_sum, N, 3'd0, 3'd4, const1, const5,
            x_out_pipe1, power_out_pipe1, sum_out_pipe1, sel_out_pipe1, ov_out_pipe1);

    pipe pp2(clk, rst, sel_out_pipe1, ov_out_pipe1, x_out_pipe1, power_out_pipe1, sum_out_pipe1, N, 3'd1, 3'd5, const2, const6,
            x_out_pipe2, power_out_pipe2, sum_out_pipe2, sel_out_pipe2, ov_out_pipe2);

    pipe pp3(clk, rst, sel_out_pipe2, ov_out_pipe2, x_out_pipe2, power_out_pipe2, sum_out_pipe2, N, 3'd2, 3'd6, const3, const7,
            x_out_pipe3, power_out_pipe3, sum_out_pipe3, sel_out_pipe3, ov_out_pipe3);

    pipe pp4(clk, rst, sel_out_pipe3, ov_out_pipe3, x_out_pipe3, power_out_pipe3, sum_out_pipe3, N, 3'd3, 3'd7, const4, const8,
            x_out_pipe4, power_out_pipe4, sum_out_pipe4, sel_out_pipe4, ov_out_pipe4);

    assign Y = sum_out_pipe4;
    assign ov = ov_out_pipe4;
    assign err = (x_out_pipe4 == 32'h80000000);

endmodule