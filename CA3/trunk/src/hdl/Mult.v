module array_multiplier #(parameter N = 8)(
    input wire [N-1:0] A, 
    input wire [N-1:0] B, 
    output wire [2*N-1:0] P
);
    wire [7:0] p[7:0]; 
    wire [54:0] c;      
    wire [42:0] s;      

    genvar i, j;
    generate
        for(i = 0; i < 8; i = i + 1) begin : gen_partial_products
            for(j = 0; j < 8; j = j + 1) begin : gen_and_gates
                And and_gate (
                    .a(A[i]), 
                    .b(B[j]), 
                    .out(p[i][j])
                );
            end
        end
    endgenerate

    assign P[0] = p[0][0];

    HA ha0 (.A(p[0][1]), .B(p[1][0]), .sum(P[1]), .cout(c[0]));
    HA ha1 (.A(p[1][1]), .B(p[2][0]), .sum(s[0]), .cout(c[1]));
    HA ha2 (.A(p[2][1]), .B(p[3][0]), .sum(s[1]), .cout(c[2]));
    HA ha3 (.A(p[3][1]), .B(p[4][0]), .sum(s[2]), .cout(c[3]));
    HA ha4 (.A(p[4][1]), .B(p[5][0]), .sum(s[3]), .cout(c[4]));
    HA ha5 (.A(p[5][1]), .B(p[6][0]), .sum(s[4]), .cout(c[5]));
    HA ha6 (.A(p[6][1]), .B(p[7][0]), .sum(s[5]), .cout(c[6]));

    FA fa0 (.A(p[0][2]), .B(c[0]), .Cin(s[0]), .Sum(P[2]), .Cout(c[7]));
    FA fa1 (.A(p[1][2]), .B(c[1]), .Cin(s[1]), .Sum(s[6]), .Cout(c[8]));
    FA fa2 (.A(p[2][2]), .B(c[2]), .Cin(s[2]), .Sum(s[7]), .Cout(c[9]));
    FA fa3 (.A(p[3][2]), .B(c[3]), .Cin(s[3]), .Sum(s[8]), .Cout(c[10]));
    FA fa4 (.A(p[4][2]), .B(c[4]), .Cin(s[4]), .Sum(s[9]), .Cout(c[11]));
    FA fa5 (.A(p[5][2]), .B(c[5]), .Cin(s[5]), .Sum(s[10]), .Cout(c[12]));
    FA fa6 (.A(p[6][2]), .B(c[6]), .Cin(p[7][1]), .Sum(s[11]), .Cout(c[13]));

    FA fa7 (.A(p[0][3]), .B(c[7]), .Cin(s[6]), .Sum(P[3]), .Cout(c[14]));
    FA fa8 (.A(p[1][3]), .B(c[8]), .Cin(s[7]), .Sum(s[12]), .Cout(c[15]));
    FA fa9 (.A(p[2][3]), .B(c[9]), .Cin(s[8]), .Sum(s[13]), .Cout(c[16]));
    FA fa10 (.A(p[3][3]), .B(c[10]), .Cin(s[9]), .Sum(s[14]), .Cout(c[17]));
    FA fa11 (.A(p[4][3]), .B(c[11]), .Cin(s[10]), .Sum(s[15]), .Cout(c[18]));
    FA fa12 (.A(p[5][3]), .B(c[12]), .Cin(s[11]), .Sum(s[16]), .Cout(c[19]));
    FA fa13 (.A(p[6][3]), .B(c[13]), .Cin(p[7][2]), .Sum(s[17]), .Cout(c[20]));

    FA fa14 (.A(p[0][4]), .B(c[14]), .Cin(s[12]), .Sum(P[4]), .Cout(c[21]));
    FA fa15 (.A(p[1][4]), .B(c[15]), .Cin(s[13]), .Sum(s[18]), .Cout(c[22]));
    FA fa16 (.A(p[2][4]), .B(c[16]), .Cin(s[14]), .Sum(s[19]), .Cout(c[23]));
    FA fa17 (.A(p[3][4]), .B(c[17]), .Cin(s[15]), .Sum(s[20]), .Cout(c[24]));
    FA fa18 (.A(p[4][4]), .B(c[18]), .Cin(s[16]), .Sum(s[21]), .Cout(c[25]));
    FA fa19 (.A(p[5][4]), .B(c[19]), .Cin(s[17]), .Sum(s[22]), .Cout(c[26]));
    FA fa20 (.A(p[6][4]), .B(c[20]), .Cin(p[7][3]), .Sum(s[23]), .Cout(c[27]));

    FA fa21 (.A(p[0][5]), .B(c[21]), .Cin(s[18]), .Sum(P[5]), .Cout(c[28]));
    FA fa22 (.A(p[1][5]), .B(c[22]), .Cin(s[19]), .Sum(s[24]), .Cout(c[29]));
    FA fa23 (.A(p[2][5]), .B(c[23]), .Cin(s[20]), .Sum(s[25]), .Cout(c[30]));
    FA fa24 (.A(p[3][5]), .B(c[24]), .Cin(s[21]), .Sum(s[26]), .Cout(c[31]));
    FA fa25 (.A(p[4][5]), .B(c[25]), .Cin(s[22]), .Sum(s[27]), .Cout(c[32]));
    FA fa26 (.A(p[5][5]), .B(c[26]), .Cin(s[23]), .Sum(s[28]), .Cout(c[33]));
    FA fa27 (.A(p[6][5]), .B(c[27]), .Cin(p[7][4]), .Sum(s[29]), .Cout(c[34]));

    FA fa28 (.A(p[0][6]), .B(c[28]), .Cin(s[24]), .Sum(P[6]), .Cout(c[35]));
    FA fa29 (.A(p[1][6]), .B(c[29]), .Cin(s[25]), .Sum(s[30]), .Cout(c[36]));
    FA fa30 (.A(p[2][6]), .B(c[30]), .Cin(s[26]), .Sum(s[31]), .Cout(c[37]));
    FA fa31 (.A(p[3][6]), .B(c[31]), .Cin(s[27]), .Sum(s[32]), .Cout(c[38]));
    FA fa32 (.A(p[4][6]), .B(c[32]), .Cin(s[28]), .Sum(s[33]), .Cout(c[39]));
    FA fa33 (.A(p[5][6]), .B(c[33]), .Cin(s[29]), .Sum(s[34]), .Cout(c[40]));
    FA fa34 (.A(p[6][6]), .B(c[34]), .Cin(p[7][5]), .Sum(s[35]), .Cout(c[41]));

    FA fa35 (.A(p[0][7]), .B(c[35]), .Cin(s[30]), .Sum(P[7]), .Cout(c[42]));
    FA fa36 (.A(p[1][7]), .B(c[36]), .Cin(s[31]), .Sum(s[36]), .Cout(c[43]));
    FA fa37 (.A(p[2][7]), .B(c[37]), .Cin(s[32]), .Sum(s[37]), .Cout(c[44]));
    FA fa38 (.A(p[3][7]), .B(c[38]), .Cin(s[33]), .Sum(s[38]), .Cout(c[45]));
    FA fa39 (.A(p[4][7]), .B(c[39]), .Cin(s[34]), .Sum(s[39]), .Cout(c[46]));
    FA fa40 (.A(p[5][7]), .B(c[40]), .Cin(s[35]), .Sum(s[40]), .Cout(c[47]));
    FA fa41 (.A(p[6][7]), .B(c[41]), .Cin(p[7][6]), .Sum(s[41]), .Cout(c[48]));

    HA ha7 (.A(c[42]), .B(s[36]), .sum(P[8]), .cout(c[49]));
    FA fa42 (.A(c[49]), .B(c[43]), .Cin(s[37]), .Sum(P[9]), .Cout(c[50]));
    FA fa43 (.A(c[50]), .B(c[44]), .Cin(s[38]), .Sum(P[10]), .Cout(c[51]));
    FA fa44 (.A(c[51]), .B(c[45]), .Cin(s[39]), .Sum(P[11]), .Cout(c[52]));
    FA fa45 (.A(c[52]), .B(c[46]), .Cin(s[40]), .Sum(P[12]), .Cout(c[53]));
    FA fa46 (.A(c[53]), .B(c[47]), .Cin(s[41]), .Sum(P[13]), .Cout(c[54]));
    FA fa47 (.A(c[54]), .B(c[48]), .Cin(p[7][7]), .Sum(P[14]), .Cout(P[15]));
endmodule
