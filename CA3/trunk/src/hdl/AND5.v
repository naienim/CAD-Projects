module AND5 (input a , b, c, d, e, output out);
    wire temp;
    AND3 and1(a, b, c, temp);
    AND3 and2(temp, d, e, out);
endmodule