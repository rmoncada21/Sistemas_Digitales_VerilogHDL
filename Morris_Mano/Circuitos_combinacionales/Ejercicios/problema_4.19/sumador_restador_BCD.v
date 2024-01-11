module sumador_restador_BCD(
    output reg[3:0] Z_SR,
    output Acarreo_out_SR,
    input Acarreo_in_SR,
    input reg [3:0] A_SR, B_SR, 
    input mux_suma_resta

);
    // Cableado interno
    wire reg [3:0] salida_complemento;
    wire reg [3:0] salida_sumador_completo;
    wire acarreo_sc;
    wire reg [3:0] salida_mux;
    
    // Instanciar los distintos modulos
    complemento_9_BCD
        C9_BCD(salida_complemento, B_SR);
    
    sumador_4bits_mnc
        SC4bits(salida_sumador_completo, acarreo_sc, 1'b0, 4'b0001, salida_complemento);
    
    mux4x1_mnc
        mux4x1(salida_mux, mux_suma_resta, B_SR, salida_sumador_completo);

    sumador_BCD_4bits
        sumador_BCD(Acarreo_out_SR, Z_SR, A_SR, salida_mux, Acarreo_in_SR);
endmodule