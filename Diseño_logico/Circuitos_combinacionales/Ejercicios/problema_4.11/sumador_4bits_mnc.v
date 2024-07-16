module sumador_4bits_mnc(
    input reg [3:0] A, B,
    output reg [3:0] Suma,
    inout reg [3:0] Acarreo
);

    // Instanciar 4 veces el sumador completo
    sumador_completo 
        SC3(Acarreo[3], Suma[3], A[3], B[3], Acarreo[2]), 
        SC2(Acarreo[2], Suma[2], A[2], B[2], Acarreo[1]),
        SC1(Acarreo[1], Suma[1], A[1], B[1], Acarreo[0]),
        SC0(Acarreo[0], Suma[0], A[0], B[0], 1'b0);

endmodule