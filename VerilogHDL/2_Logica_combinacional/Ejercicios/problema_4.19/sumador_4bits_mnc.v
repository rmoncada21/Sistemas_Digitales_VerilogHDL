module sumador_4bits_mnc(
    output reg [3:0] Suma,
    output Acarreo_suma_4bits,
    input Acarreo_entrada,
    input reg [3:0] A, B

);
    wire reg [2:0] Acarreo_interno;

    // Instanciar 4 veces el sumador completo
    sumador_completo
        SC3(Acarreo_suma_4bits, Suma[3], A[3], B[3], Acarreo_interno[2]), 
        SC2(Acarreo_interno[2], Suma[2], A[2], B[2], Acarreo_interno[1]),
        SC1(Acarreo_interno[1], Suma[1], A[1], B[1], Acarreo_interno[0]),
        SC0(Acarreo_interno[0], Suma[0], A[0], B[0], Acarreo_entrada);

endmodule

// output Acarreo_suma_4bits;
// wire reg [2:0] Acarreo_interno;
