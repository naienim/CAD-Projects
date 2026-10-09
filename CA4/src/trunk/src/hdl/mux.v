module mux #(parameter WIDTH = 32) (input[WIDTH-1:0] num1, num2, input sel, output[WIDTH-1:0] out_mux);
    assign out_mux = sel ? num2  : num1;
endmodule