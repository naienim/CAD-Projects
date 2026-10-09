module pipe(input clk, rst, sel_mux, in_ov, input [31:0] x_inp, x_power_in, sum_in, 
            input[2:0] N, pipe_index1, pipe_index2, input [31:0] const_first, const_second,
            output [31:0] out_x_inp, x_power_out, sum_out, output out_sel_mux, out_ov);

    wire [31:0] new_exp, new_power_x, temp_sum, final_sum, final_cost;
    wire [2:0] final_pipe_index;
    wire compare_result, pipe_ov;

    mux #(3) pipe_index_mux(pipe_index1, pipe_index2, sel_mux, final_pipe_index);
    mux #(32) const_mux(const_first, const_second, sel_mux, final_cost);
    comparator comp(N, final_pipe_index, compare_result);
    multiplier mult1(x_inp, x_power_in, new_power_x);
    multiplier mult2(final_cost, new_power_x, new_exp);
    adder add(new_exp, sum_in, temp_sum);
    mux #(32) sum_mux(temp_sum, sum_in, compare_result, final_sum);
    ov_detector ov_detect(in_ov, compare_result, sum_in, new_exp, temp_sum, pipe_ov);
    register pipe_register(clk, rst, pipe_ov, sel_mux, x_inp, new_power_x, final_sum, 
                            out_ov, out_sel_mux, out_x_inp, x_power_out, sum_out);
endmodule