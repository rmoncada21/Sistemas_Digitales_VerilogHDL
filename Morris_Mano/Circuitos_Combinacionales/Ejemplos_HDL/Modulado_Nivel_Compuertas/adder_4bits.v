// Descripción de un sumador de 4 bits

module adder_4bits (S,C4,A,B,C0);
    input [3:0] A,B;
    input C0;
    output [4:0] S;
    output C4;
    wire C1,C2,C3; // Acarreos
    // Crear ejemplares del sumador completo
    full_adder FA0 (S[0], C1, A[0], B[0], C0),
               FA1 (S[1], C2, A[1], B[1], C1),
               FA2 (S[2], C3, A[2], B[2], C2),
               FA3 (S[3], C4, A[3], B[3], C3);
endmodule