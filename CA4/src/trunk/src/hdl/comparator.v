module comparator(input [2:0] N, pipe_index, output is_greater);
    assign is_greater = (pipe_index > N);
endmodule