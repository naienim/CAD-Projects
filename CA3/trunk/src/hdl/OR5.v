module OR5 (input a , b, c, d, e, output out);
    wire temp;
    OR3 or1(a, b, c, temp);
    OR3 or2(temp, d, e, out);
endmodule