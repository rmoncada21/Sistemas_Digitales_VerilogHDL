// Modelado por flujo de datos

module circuito_mfd(A, B, C, D, F1, F2);
    input A, B, C, D;
    output F1, F2;

    wire w1, w2, w3, w4, w5;

    assign w1 = ~B & C;
    assign w2 = A & D;
    assign w3 = B & ~D;
    assign w4 = ~A & B & ~D;
    assign w5 = ~A & B;

    assign F1 = A + w1 + w2 + w3 + w4;
    assign F2 = w5 + D;
endmodule