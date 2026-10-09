module FA (input wire A, input wire B, input wire Cin, output wire Sum, output wire Cout);
    wire AxorB;
    wire AandB;
    wire XorAndCin;
    Xor x1(.out(AxorB), .a(A), .b(B));
    Xor x2(.out(Sum), .a(AxorB), .b(Cin));
    Mux2to1 #(1) mxx(.in0(A), .in1(Cin), .sel(AxorB), .out(Cout));
endmodule