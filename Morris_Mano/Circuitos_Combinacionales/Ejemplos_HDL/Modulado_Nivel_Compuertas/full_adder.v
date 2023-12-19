module full_adder (S,C,x,y,z);
    input x,y,z;
    output S,C;
    // Salidas de la primera XOR y dos compuertas AND
    wire S1,D1,D2;

    // Crear un ejemplar del semisumador
    half_adder HA1(S1,D1,x,y), HA2 (S,D2,S1,z);

    or g1(C,D2,D1);

endmodule