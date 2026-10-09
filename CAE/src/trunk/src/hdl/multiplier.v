module multiplier(input signed  [31:0] num1, num2, output signed [31:0] mult_out);
    wire [63:0] temp;
	assign temp = num1 * num2;
    assign mult_out = temp[62:31];
endmodule