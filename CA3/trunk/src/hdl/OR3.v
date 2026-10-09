module OR3 (input a , b, c, output out);
    C2 #(1) C22(.D00(1'b0), .D01(1'b1), .D10(1'b1), .D11(1'b1), .A1(a), .B1(b), .A0(c), .B0(1'b1), .out(out));
endmodule