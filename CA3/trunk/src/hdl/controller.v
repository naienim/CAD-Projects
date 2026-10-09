module controller (input clk, rst, start, CO_up, CO_down, A_MSB, B_MSB, rst_begin,
                        output sel, ld1, ld2, en_sh1, sh_dir, en_sh2, cnt_en, cnt_dir, done);
        wire o1, o2, o3, o4, o5, o6, o7, o8, o9, o10;
        wire result1, result2, result3, result4, result5, result6, result7, result8, result9, result10;
        wire idle1, start1, start2, num11, num21, num22, mult1;
        wire not_start, not_A_MSB, not_B_MSB, not_CO_up, not_CO_down;
        
        Not not_1(start, not_start);
        Not not_2(A_MSB, not_A_MSB);
        Not not_3(B_MSB, not_B_MSB);
        Not not_4(CO_up, not_CO_up);
        Not not_5(CO_down, not_CO_down);

        // Idle
        And and_idle(not_start, o1, idle1);
        OR3 or_idle(o10, rst, idle1, result1);
        reg_1bit idle(clk, rst_begin, 1'b1, result1, o1);

        // Start
        And and_start1(o1, start, start1);
        And and_start2(o2, start, start2);
        Or or_start(start1, start2, result2);
        reg_1bit start_state(clk, rst, 1'b1, result2, o2);

        // Num1
        And and_num1(o2, not_start, num11);
        Or or_num1(num11, o4, result3);
        reg_1bit num1(clk, rst, 1'b1, result3, o3);

        // Wait1
        AND3 and_wait1(o3, not_A_MSB, not_CO_up, result4);
        reg_1bit wait1(clk, rst, 1'b1, result4, o4);

        // Num2
        Or or_num2(A_MSB, CO_up, num21);
        And and_num2(o3, num21, num22);
        Or or_num2_result(num22, o6, result5);
        reg_1bit num2(clk, rst, 1'b1, result5, o5);

        // Wait2
        AND3 and_wait2(o5, not_B_MSB, not_CO_up, result6);
        reg_1bit wait2(clk, rst, 1'b1, result6, o6);

        // Mult
        Or or_mult(B_MSB, CO_up, mult1);
        And and_mult(o5, mult1, result7);
        reg_1bit mult(clk, rst, 1'b1, result7, o7);

        // Down
        Or or_down(o7, o9, result8);
        reg_1bit down(clk, rst, 1'b1, result8, o8);

        // Wait3
        And and_wait3(o8, not_CO_down, result9);
        reg_1bit wait3(clk, rst, 1'b1, result9, o9);

        // Done
        And and_done(o8, CO_down, result10);
        reg_1bit done_state(clk, rst, 1'b1, result10, o10);

        assign sel = o7;
        Or ld1_or(o7, o2, ld1);
        assign ld2 = o2;
        Or en_sh1_or(o4, o9, en_sh1);
        assign en_sh2 = o6;
        assign sh_dir = o4;
        OR3 cnt_en_or(o4, o6, o9, cnt_en);
        assign cnt_dir = o9;
        assign done = o10;
endmodule