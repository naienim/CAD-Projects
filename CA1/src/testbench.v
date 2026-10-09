`timescale 1ns/1ns
module tb();
    reg clk=1'b1, rst=1'b0, start=1'b0;

    wire done;

    top cut(clk, rst, start, done);
    
    always #20 clk =~ clk;

    initial begin
        #50 rst=1'b1;
        #50 rst=1'b0;
        #50 start = 1'b1;
        #50 start = 1'b0;
        #50000 $stop;
    end

endmodule