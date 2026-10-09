module Mux4To1 (input in0, in1, in2, in3,input[1:0] sel,output out);
    C2 #1 C2_MUX4T1(.D00(in0), .D01(in1), .D10(in2), .D11(in3), .A1(sel[1]), .B1(1'b0), .A0(sel[0]), .B0(1'b1), .out(out));
endmodule