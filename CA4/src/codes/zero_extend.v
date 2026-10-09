module zero_extend(input [7:0] X, output [31:0] out_X);
    assign out_X = {X, 24'b0};
endmodule