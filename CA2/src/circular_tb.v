`timescale 1ns/1ns

module circular_buffer_tb;
    parameter DATA_WIDTH = 8;
    parameter BUFFER_SIZE = 7;
    parameter W_PARAM = 2;
    parameter R_PARAM = 2;

    reg clk, rst;
    reg w_enable, r_enable;
    reg [DATA_WIDTH*W_PARAM-1:0] inp;

    wire full, empty, ready, valid;
    wire [DATA_WIDTH*R_PARAM-1:0] data_out;
    

    circular_buffer #(.DATA_WIDTH(DATA_WIDTH), .BUFFER_SIZE(BUFFER_SIZE), .W_PARAM(W_PARAM), .R_PARAM(R_PARAM)) 
                    uut (.clk(clk), .rst(rst), .write_en(w_enable), .read_en(r_enable), .inp(inp), 
                        .full(full), .empty(empty), .ready(ready), .valid(valid), .data_out(data_out));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        w_enable = 0;
        r_enable = 0;
        inp = 0;

        #10;
        rst = 0;

        inp = {8'h01, 8'h02}; 
        w_enable = 1;
        #10;
        w_enable = 0;

        #10;

        inp = {8'h03, 8'h04}; 
        w_enable = 1;
        #10;
        w_enable = 0;

        #10;

        // inp = {8'h03, 8'h04}; 
        // w_enable = 1;
        // #10;
        // w_enable = 0;

        // #10;

        // inp = {8'h05, 8'h06}; 
        // w_enable = 1;
        // #10;
        // w_enable = 0;

        // #10;

        // Enable read to retrieve the values
        // r_enable = 1;
        // #10;
        // r_enable = 0;
        // #10;
        
        // r_enable = 1;
        // #10;
        // r_enable = 0;
        // #10;

        // r_enable = 1;
        // #10;
        // r_enable = 0;
        // #10;

        inp = {8'h05, 8'h06}; 
        w_enable = 1;
        #10;
        w_enable = 0;

        #10;

        inp = {8'h07, 8'h08}; 
        w_enable = 1;
        #10;
        w_enable = 0;

        #10;

        r_enable = 1;
        #10;
        r_enable = 0;
        #10;

        r_enable = 1;
        #10;
        r_enable = 0;
        #10;

        r_enable = 1;
        #10;
        r_enable = 0;
        #10;

        r_enable = 1;
        #10;
        r_enable = 0;
        #10;

        inp = {8'h07, 8'h08}; 
        w_enable = 1;
        #10;
        w_enable = 0;

        #10;

        inp = {8'h09, 8'h0a}; 
        w_enable = 1;
        #10;
        w_enable = 0;

        #10;

        r_enable = 1;
        #10;
        r_enable = 0;
        #10;

        r_enable = 1;
        #10;
        r_enable = 0;
        #10;

        r_enable = 1;
        #10;
        r_enable = 0;
        #10;

        $stop; 
    end

endmodule
