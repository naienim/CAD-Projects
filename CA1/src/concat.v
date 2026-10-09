module concat(input one_bit, input [7:0] data, output [7:0] out);
    assign out = one_bit ? {one_bit, data[7:1]} : data;
endmodule
