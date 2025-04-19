// Ejemplo HDL 4.3
// Descripción de flujo de datos del decodificador de 2 a 4

module decode2x4 (A,B,E,D);
    input A ,B, E;
    output [0:3] D;
    assign D[0] = ~(~A & ~B & ~E),
           D[1] = ~(~A & B & ~E),
           D[2] = ~(A & ~B & ~E),
           D[3] = ~(A & B & ~E);
endmodule
