module sumador_completo(
    input A, B, Ci, // Ci: accarreo de entrada
    output Co, Suma 
);
    assign Suma = A^B^Ci;
    assign Co = Ci&(A^B) | (A&B);

endmodule