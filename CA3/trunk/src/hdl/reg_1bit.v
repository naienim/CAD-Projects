module reg_1bit (input clk, rst, en, input in, output wire out);
    S2 #1 S2_REG(.D00(out), .D01(in), .D10(), .D11(), .A1(1'b0), .B1(1'b0), .A0(en), .B0(1'b1), .CLR(rst), .CLK(clk), .out(out));
endmodule