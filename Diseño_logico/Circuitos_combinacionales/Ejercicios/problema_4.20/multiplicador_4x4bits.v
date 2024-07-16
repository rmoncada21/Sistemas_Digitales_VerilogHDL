module multiplicador_4x4bits(
    output reg [7:0] M,
    input reg [3:0] xm, ym
);
    wire [3:0] salida_mult_0;
    wire [3:0] salida_suma_0;
    wire Acarreo_SC0;

    wire [3:0] salida_mult_1;
    wire [3:0] salida_suma_1;
    wire Acarreo_SC1;

    wire [3:0] salida_mult_2;
    wire [3:0] salida_mult_3;
    // wire [3:0] salida_suma_2;
    // No se usa
    // wire Acarreo_SC2;

    // Instanciar modulos
    multiplicador_1bit 
        mult_1bit_0(salida_mult_0, xm, ym[0]),
        mult_1bit_1(salida_mult_1, xm, ym[1]),
        mult_1bit_2(salida_mult_2, xm, ym[2]),
        mult_1bit_3(salida_mult_3, xm, ym[3]);

    sumador_4bits_mnc
        sc_4bits_0(salida_suma_0, Acarreo_SC0, 1'b0, {1'b0, salida_mult_0[3:1]}, salida_mult_1),
        sc_4bits_1(salida_suma_1, Acarreo_SC1, 1'b0, {Acarreo_SC0, salida_suma_0[3:1]}, salida_mult_2),
        sc_4bits_2(M[6:3], M[7], 1'b0, {Acarreo_SC1, salida_suma_1[3:1]}, salida_mult_3);
    
    buf
        b_mult_0(M[0], salida_mult_0[0]),
        b_sc_4bits_0(M[1], salida_suma_0[0]),
        b_sc_4bits_1(M[2], salida_suma_1[0]);

endmodule
