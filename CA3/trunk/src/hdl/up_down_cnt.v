module up_downcnt (
    input clk,               
    input reset,             
    input en,                
    input dir,            
    input load,    
    input [4:0] parIn,       
    output [4:0] count,      
    output bout_down,
    output bout_up
);

    wire [4:0] q;            
    wire [4:0] next_count;   
    wire [4:0] dec_input;
    wire temp;
    Mux2to1 mx(5'b00001, 5'b11111, dir, dec_input); 
    Adder #5 dec_inst (
        .a(q),               
        .b(dec_input),       
        .cin(1'b0),          
        .s(next_count),      
        .cout()              
    );
    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin : gen_register
            reg_1bit reg_inst (
                .clk(clk),
                .rst(reset),
                .en(en),
                .in(next_count[i]),
                .out(q[i])
            );
        end
    endgenerate
    
    OR5 down_out(q[0], q[1], q[2], q[3], q[4], temp);
    AND5 up_out(q[0], q[1], q[2], q[3], q[4], bout_up);
    Not co_down_not(temp, bout_down);
endmodule