`timescale 1ns/1ns
module counter #(parameter WIDTH = 4) (
    input clk, rst, ld, en,
    input [WIDTH-1:0] pin,
    output cout,
    output reg [WIDTH-1:0] pout
);

    always @(posedge clk) begin
        if (rst)
            pout <= {WIDTH{1'b0}}; 
        else begin
            if (ld)
                pout <= pin; 
            else if (en)
                pout <= pout + 1; 
        end            
    end

    assign cout = &pout; 
endmodule
