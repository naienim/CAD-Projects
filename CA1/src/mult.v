module mult(input [7:0] num1, num2, output reg [15:0] out);
    reg [15:0] data;
    always@(*)begin
        data = num1 * num2;
    end
    assign out = data;
endmodule
