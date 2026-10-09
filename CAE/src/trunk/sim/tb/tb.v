`timescale 1ns/1ns
module	tb();
	reg clk=1'b0, rst = 1'b0, start = 1'b0;
    wire ready, valid, overflow, error;
    wire [31:0] Y;
    reg [7:0] X;
    reg [2:0] N;
	top	CUT(clk, rst, start, N, X, overflow, error, ready, valid, Y);
	initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

	initial begin
        #10 rst = 1;
        #10 rst = 0;
        #10 start = 0;
        #10 start = 1;
        #10 start = 0;
        #10 N = 3'd7;
        #10 X = 8'b01111111;
        #10 X = 8'b11000000;
        #10 X = 8'b00100000;
        #10 X = 8'b00010000;
        #10
        #10
        #10
        #10
        #10 X = 8'b01111111;
        #10 X = 8'b11000000;
        #10 X = 8'b00100000;
        #10 X = 8'b00010000;
        #10
        #10
        #10
        #10
        #10 X = 8'b01111111;
        #10 X = 8'b11000000;
        #10 X = 8'b00100000;
        #10 X = 8'b10011001;
        #10
        #10
        #10
        #10
        #80;
	$stop;
	
	end
endmodule

