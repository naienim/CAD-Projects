`define Idle 5'b00000
`define Wait 5'b00001
`define Read 5'b00010
`define LoadInp 5'b00011
`define Shift1 5'b00100
`define Decide 5'b00101 
`define Overflow 5'b00110 
`define Count1 5'b00111
`define Correction 5'b01000
`define Concat 5'b01001 
`define NextInp 5'b01010 
`define Mult 5'b01011 
`define Load 5'b01100
`define Combine 5'b01101
`define Shift2 5'b01110
`define Count2 5'b01111
`define Write 5'b10000
`define Check 5'b10001
`define Count3 5'b10010
`define Done 5'b10011


module controller (clk, rst, start, found, co_cnt1, co_cnt2, co_cnt3, co_cnt4, co_downcnt,
                    ld_cnt1, ld_cnt2, ld_cnt3, ld_cnt4, read, ld_shiftreg, ld_res, shift_left, shift_right, en_cnt1,
                    en_cnt2, en_cnt3, en_cnt4,ld_inp1, ld_inp2, ld_now1, ld_now2, ld_downcnt, en_downcnt, write, ld_co_inp1, ld_co_inp2, done);

    input clk, rst, start, found, co_cnt1, co_cnt2, co_cnt3, co_cnt4, co_downcnt;

    output ld_cnt1, ld_cnt2, ld_cnt3, ld_cnt4, read, ld_shiftreg, ld_res, shift_left, shift_right, en_cnt1,
            en_cnt2, en_cnt3, en_cnt4,ld_inp1, ld_inp2, ld_now1, ld_now2, ld_downcnt, en_downcnt, write, ld_co_inp1, ld_co_inp2, done;

    reg ld_cnt1, ld_cnt2, ld_cnt3, ld_cnt4, read, ld_shiftreg, ld_res, shift_left, shift_right, en_cnt1,
        en_cnt2, en_cnt3, en_cnt4,ld_inp1, ld_inp2, ld_now1, ld_now2, ld_downcnt, en_downcnt, write,ld_co_inp1, ld_co_inp2, done;

    reg [4:0] ps, ns;
    always @(posedge clk) begin
        if(rst)
            ps <= `Idle;
        else
            ps <= ns;
    end

    always @(ps, start, found, co_cnt1, co_cnt2, co_cnt3, co_cnt4, co_downcnt) begin
        case(ps) 
            `Idle: ns = start ? `Wait : `Idle;
            `Wait: ns = start ? `Wait : `Read;
            `Read: ns = `LoadInp;
            `LoadInp: ns = `Shift1;
            `Shift1: ns = `Decide;
            `Decide: ns = found ? `Concat : `Overflow;
            `Overflow: ns = co_cnt2 ? `Correction : `Count1;
            `Count1: ns = `Shift1;
            `Correction: ns = `Concat;
            `Concat: ns = co_cnt3 ? `Mult : `NextInp;
            `NextInp: ns = `Read;
            `Mult: ns = `Load;
            `Load: ns = `Combine;
            `Combine: ns = co_downcnt ? `Write : `Shift2;
            `Shift2: ns = `Count2;
            `Count2: ns = `Combine;
            `Write: ns = `Check;
            `Check: ns = co_cnt4 ? `Done : `Count3;
            `Count3: ns = `Read;
            `Done: ns = `Idle;
            default: ns = `Idle;
        endcase
    end     
    
    always @(ps) begin
        {ld_cnt1, ld_cnt2, ld_cnt3, ld_cnt4, read, ld_shiftreg, ld_res, shift_left, shift_right, en_cnt1} = 10'b0;
        {en_cnt2, en_cnt3, en_cnt4, ld_inp1, ld_inp2, ld_now1, ld_now2, ld_downcnt, en_downcnt, write, done} = 11'b0;
        {ld_co_inp1, ld_co_inp2} = 2'b0;
        case(ps) 
            `Idle: ;
            `Wait: {ld_cnt1, ld_cnt4, ld_cnt2, ld_cnt3} = 4'b1111;
            `Read: {read, ld_cnt2, ld_co_inp1} = 3'b111;
            `LoadInp: {ld_shiftreg, ld_co_inp2} = 2'b11;
            `Shift1: {shift_left} = 1'b1;
            `Decide: ;
            `Overflow: ; 
            `Count1: {en_cnt2} = 1'b1;
            `Correction:;
            `Concat: ;
            `NextInp: {ld_now1, ld_inp1, en_cnt1, en_cnt3, ld_co_inp1} = {4'b1111, ~found};
            `Mult: {ld_inp2, ld_now2, ld_co_inp2} = {2'b11, ~found};
            `Load: {ld_res, ld_downcnt} = 2'b11;
            `Combine:  ;
            `Shift2: {shift_right} = 1'b1;
            `Count2: {en_downcnt} = 1'b1;
            `Write: {write} = 1'b1;
            `Check:  ;
            `Count3: {en_cnt1, en_cnt4, ld_cnt2, ld_cnt3} = 4'b1111;
            `Done: {done, write} = 2'b11;
        endcase     
    end

endmodule



