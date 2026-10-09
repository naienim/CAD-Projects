`timescale 1ns/1ns
module counter #(parameter WIDTH = 2) (input clk, rst, output cout);

    reg [WIDTH-1:0] pout;
    always @(posedge clk) begin
        if (rst)
            pout <= {WIDTH{1'b0}}; 
        else 
            pout <= pout + 1; 
    end

    assign cout = &pout; 
endmodule