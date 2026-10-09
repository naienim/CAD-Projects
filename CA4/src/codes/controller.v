`define Idle 4'b0000
`define Wait 4'b0001
`define Decide 4'b0010
`define N_less 4'b0011
`define N_less_valid 4'b0100
`define N_more 4'b0101 
`define N_more_invalid 4'b0110 
`define N_more_valid 4'b0111
`define Error 4'b1000


module controller(input clk, start, reset, ov, err, input [2:0] N, output reg overflow, error, ready, valid, sel);
    reg [3:0] ps, ns;
    reg rst1, rst2;
    wire more_than_4, co1, co2;

    assign more_than_4 = (N > 3'd3) ? 1 : 0;
    counter cnt1(.clk(clk), .rst(rst1), .cout(co1));
    counter cnt2(.clk(clk), .rst(rst2), .cout(co2));

    always @(posedge clk) begin
        if(reset)
            ps <= `Idle;
        else begin
            if (error)
                ps <= `Error;
            else
                ps <= ns;
        end
    end

    always @(ps, start, more_than_4, co1, co2) begin
        case(ps) 
            `Idle: ns = start ? `Wait : `Idle;
            `Wait: ns = start ? `Wait : `Decide;
            `Decide: ns = more_than_4 ? `N_more : `N_less;

            `N_less: ns = co1 ? `N_less_valid : `N_less;
            `N_less_valid: ns = `N_less_valid;

            `N_more: ns = co1 ? `N_more_invalid : `N_more;
            `N_more_invalid: ns = co2 ? `N_more_valid : `N_more_invalid;
            `N_more_valid: ns = co1 ? `N_more_invalid : `N_more_valid;

            `Error: ns = `Error;
            
            default: ns = `Idle;
        endcase
    end     
    
    always @(ps, ov, err) begin
        {overflow, error, ready, valid, sel, rst1, rst2} = 7'b0;
        case(ps) 
            `Idle: ;
            `Wait: ;
            `Decide: {rst1, rst2} = 2'b11;

            `N_less: {ready} = 1'b1;
            `N_less_valid: {ready, valid, overflow, error} = {~err, ~(ov | err), (ov & ~err), err};

            `N_more: {ready, rst2} = 2'b11;
            `N_more_invalid: {rst1, sel} = 2'b11;
            `N_more_valid: {ready, rst2, valid, overflow, error} = {~err, 1'b1, ~(ov | err), (ov & ~err), err};

            `Error: {error} = {1'b1};
        endcase     
    end
endmodule