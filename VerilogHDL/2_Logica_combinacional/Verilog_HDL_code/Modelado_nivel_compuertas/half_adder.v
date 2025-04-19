// Descripcion jerarquica a ni vel de compuertas de un sumador de 4 bits

module half_adder (S,C,x,y);
    input x,y;
    output S,C;
    // Crear ejemplares de compuertas primitivas
    xor (S,x,y);
    and (C,x,y);
endmodule