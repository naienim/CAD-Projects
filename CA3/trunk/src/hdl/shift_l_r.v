module shift_reg #(parameter WIDTH = 8)
                  (input clk, 
                   input reset, 
                   input load, 
                   input [WIDTH-1:0] data_in, 
                   input serial_in, 
                   input shift_en, 
                   input shift_dir, 
                   output [WIDTH-1:0] data_out, 
                   output carry_out);

    wire [WIDTH+1:0] shift_chain;
    assign shift_chain[WIDTH+1] = serial_in;
    assign shift_chain[0] = serial_in;      
    wire all_en;
    Or or_en(shift_en, load, all_en);

    genvar i;
    generate
        for (i = 1; i < WIDTH + 1; i = i + 1) begin : gen_shift_reg
            wire data_select;
            Mux4To1 mx4to1(shift_chain[i+1], shift_chain[i-1], data_in[i-1], data_in[i-1], {load, shift_dir}, data_select);
            reg_1bit reg_inst (
                .clk(clk),
                .rst(reset),
                .en(all_en),
                .in(data_select),
                .out(shift_chain[i])
            );
        end
    endgenerate
    assign data_out = shift_chain[WIDTH:1];
    assign carry_out = shift_chain[WIDTH];
endmodule
