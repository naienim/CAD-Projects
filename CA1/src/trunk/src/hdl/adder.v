module adder(input [2:0] num1, num2, num3, num4, output reg [4:0] out);
    reg [4:0] data;
    always@(*)begin
        data = num1 + num2 + num3 + num4;
    end
    assign out = data;
endmodule