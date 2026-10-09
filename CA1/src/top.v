module top(input clk, rst, start, output done);
    wire ld_cnt1, ld_cnt2, ld_cnt3, ld_cnt4, read, ld_shiftreg, ld_res, shift_left, shift_right, en_cnt1,
                en_cnt2, en_cnt3, en_cnt4,ld_inp1, ld_inp2, ld_now1, ld_now2, ld_downcnt, en_downcnt, write, 
                found, co_cnt1, co_cnt2, co_cnt3, co_cnt4, co_downcnt;

    datapath dp(clk, rst, ld_cnt1, ld_cnt2, ld_cnt3, ld_cnt4, read, ld_shiftreg, ld_res, shift_left, shift_right, en_cnt1,
                ld_co_inp1, ld_co_inp2, en_cnt2, en_cnt3, en_cnt4,ld_inp1, ld_inp2, ld_now1, ld_now2, ld_downcnt, en_downcnt, write, 
                found, co_cnt1, co_cnt2, co_cnt3, co_cnt4, co_downcnt);

    controller cont(clk, rst, start, found, co_cnt1, co_cnt2, co_cnt3, co_cnt4, co_downcnt,
                    ld_cnt1, ld_cnt2, ld_cnt3, ld_cnt4, read, ld_shiftreg, ld_res, shift_left, shift_right, en_cnt1,
                    en_cnt2, en_cnt3, en_cnt4,ld_inp1, ld_inp2, ld_now1, ld_now2, ld_downcnt, en_downcnt, write, ld_co_inp1, ld_co_inp2, done);
endmodule