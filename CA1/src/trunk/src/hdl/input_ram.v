`timescale 1ns/1ns
module input_ram(clk, address, read_data, data);
    input [3:0] address;
    input read_data, clk;
    output reg [15:0] data;

    reg [15:0] mem [15:0];

    initial begin
        $readmemb("data_input.txt", mem);
    end

    always @(posedge clk, read_data) begin
        if (read_data)
            data <= mem[address];
    end
endmodule