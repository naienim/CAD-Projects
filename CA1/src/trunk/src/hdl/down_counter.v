module down_counter(input clk, rst, ld, en, input [4:0] pin, output cout, output reg [4:0] pout);
    always @(posedge clk) begin
        if (rst)
            pout <= {4{1'b0}}; 
        else begin
            if (ld)
                pout <= pin; 
            else if (en)
                pout <= pout - 1; 
        end            
    end
    assign cout = ~|pout;    
endmodule