module top #(parameter OUTPUT_WIDTH = 32) 
            (input clk, rst, start, input [2:0] N, input [7:0] X, output overflow, error, ready, valid, output [31:0] Y);

    wire [2:0] new_N;
    wire sel, ov, err;

    assign new_N = {N > 3'b0} ? N -1 : 3'd7;
    datapath dp(clk, rst, sel, X, new_N, ov, err, Y);
    controller cont(clk, start, rst, ov, err, new_N, overflow, error, ready, valid, sel);

endmodule