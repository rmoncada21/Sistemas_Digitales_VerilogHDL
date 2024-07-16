/*
    Sumadr BCD se compone de 2 sumadore completos de 4 bits
    mas un cicruito combinacional
*/

module sumador_BCD_4bits(
    output Acarreo_BCD,
    output reg [3:0] Z_salida,
    input reg [3:0] A, B, 
    input Ac_in
);
    
    // Cableado interno
    wire 
        // Acarreo de salida del primer sumador
        Ac_out,
        sin_usar;
    
    wire reg [3:0] SCA_suma;
    
    // Instanciar modulos
    // Sumadores de 4bits
    sumador_4bits_mnc
        SCA_4bits(SCA_suma, Ac_out, Ac_in, A, B),
        SCB_4bits(Z_salida, sin_usar, Ac_in, {1'b0,Acarreo_BCD, Acarreo_BCD, 1'b0}, SCA_suma);

    acarreo_BCD
        Ac_BCD(Acarreo_BCD, SCA_suma[3], SCA_suma[2], SCA_suma[1], Ac_out);
endmodule