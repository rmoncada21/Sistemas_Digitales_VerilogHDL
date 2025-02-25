module circuito_mfd(
    input reg [2:0] XYZ,
    output reg [2:0] ABC
);
    // Variables para simplificar las asignaciones
    reg x, y, z;
    assign x= XYZ[2];
    assign y= XYZ[1];
    assign z= XYZ[0];

    // Modelado por flujo de datos
    assign 
        // Salida A
        ABC[2] = (y & z) | (x & (y | z)),
        // Salida B
        ABC[1] = (x & ( (~y & ~z)| (y & z))) | (~x & (y ^ z)),
        // Salida C
        ABC[0] = (~z);
    
endmodule