module top  (input clk, rst, start, rst_begin, input [15:0] A, B, output done, output [15:0] out);

    wire CO_up, CO_down, A_MSB, B_MSB, sel, ld1, ld2, en_sh1, sh_dir, en_sh2, cnt_en, cnt_dir;

    controller cont (clk, rst, start, CO_up, CO_down, A_MSB, B_MSB, rst_begin,
                        sel, ld1, ld2, en_sh1, sh_dir, en_sh2, cnt_en, cnt_dir, done);

    datapath dp(clk, rst, sel, ld1, ld2, en_sh1, sh_dir, en_sh2, cnt_en, cnt_dir,  
                A, B, out, CO_up, CO_down, A_MSB, B_MSB);

endmodule