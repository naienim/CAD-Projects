`timescale 1ns / 1ps

module tb;
    reg clk;
    reg rst;
    reg rst_begin;
    reg start;
    reg [15:0] A;
    reg [15:0] B;

    wire done;
    wire [15:0] out;

    top uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .rst_begin(rst_begin),
        .A(A),
        .B(B),
        .done(done),
        .out(out)
    );

    always #5 clk = ~clk; 

    initial begin
        rst_begin = 1;
        rst = 1;
        clk = 0;
        start = 0;
        A = 16'b0;
        B = 16'b0;
        #20
        rst_begin = 0;

        #10 rst = 0;
        A = 16'h4000; 
        B = 16'h4000; 
        #20;
        start = 1;
        #10 start = 0;

        wait(done);
        #40;

        A = 16'h8000; 
        B = 16'h8000; 
        #20;
        start = 1;
        #10 start = 0;

        wait(done);
        #40;

        A = 16'h0030; 
        B = 16'h00a0; 
        #20;
        start = 1;
        #10 start = 0;

        wait(done);
        #40;
        $stop;
    end
endmodule
