module HA (input A, B, output sum, cout);
    Xor xorr(A, B, sum);
    And andd(A, B, cout);
endmodule