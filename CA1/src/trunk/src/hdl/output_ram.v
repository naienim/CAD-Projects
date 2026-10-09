`timescale 1ns/1ns
module  output_ram(input clk, input write, input write_on_file, input [2:0] address, input [31:0] data);
    reg [31:0] memory [0:7];
    always @(posedge clk, write) begin
        if (write) begin
            memory[address] <= data;
        end
        if (write_on_file) begin
            $writememh("data_output.txt" , memory);
        end
    end
endmodule