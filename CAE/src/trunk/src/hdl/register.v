module register(input clk, rst, pre_ov, pre_sel, input [31:0] pre_X, pre_X_power, pre_sum,
                output reg out_ov, out_sel, output reg [31:0] out_X, out_X_power, out_pre_sum);
    always @(posedge clk) begin
        if(rst) begin
            {out_ov, out_sel} <= 2'd0;
            {out_X, out_X_power, out_pre_sum}  <= {3*32'd0};
        end
        else begin
            {out_ov, out_sel} <= {pre_ov, pre_sel};
            {out_X, out_X_power, out_pre_sum} <= {pre_X, pre_X_power, pre_sum};
        end
    end
endmodule