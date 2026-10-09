module datapath(input clk, rst, sel, ld1, ld2, en_sh1, sh_dir, en_sh2, cnt_en, cnt_dir,  
                input [15:0] A, B, output [15:0] out, output CO_up, CO_down, A_MSB, B_MSB);
        
    wire [15:0] A_shifted, B_shifted, mult_out, mux_out;

    Mux2to1 #(16) mux16 (
        .in0(A),
        .in1(mult_out),
        .sel(sel), 
        .out(mux_out)
    );

    shift_reg #(16) sh1 (
        .clk(clk), 
        .reset(rst), 
        .load(ld1), 
        .data_in(mux_out), 
        .serial_in(1'b0), 
        .shift_en(en_sh1), 
        .shift_dir(sh_dir),  
        .data_out(A_shifted), 
        .carry_out(A_MSB)
    );

    shift_reg #(16) sh2 (
        .clk(clk), 
        .reset(rst), 
        .load(ld2), 
        .data_in(B), 
        .serial_in(1'b0), 
        .shift_en(en_sh2), 
        .shift_dir(1'b1),  
        .data_out(B_shifted), 
        .carry_out(B_MSB)
    );

    array_multiplier multiplier(
        .A(A_shifted[15:8]), 
        .B(B_shifted[15:8]), 
        .P(mult_out)
    );

    up_downcnt counter (
        .clk(clk),               
        .reset(rst),             
        .en(cnt_en),                
        .dir(cnt_dir),     
        .load(),    
        .parIn(),       
        .count(),      
        .bout_down(CO_down),
        .bout_up(CO_up)
    );

    assign out = A_shifted;
endmodule