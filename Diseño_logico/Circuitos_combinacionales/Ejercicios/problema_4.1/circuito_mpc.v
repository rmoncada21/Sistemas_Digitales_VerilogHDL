// Circuito del ejercicio 4.1 modelado por comportamiento
// Modelado por comportamiento

module circuito_mpc (A, B, C, D, F1, F2);
    input A, B, C, D;
    output F1, F2;

    //  En Verilog, las asignaciones dentro de un bloque always @* deben 
    // realizarse en variables reg, no en salidas wire
    reg reg_F1, reg_F2;

    // Con el @* se activa cada vez que haya un cambio en 
    // cualquiera de la variables
    always @* begin
        reg_F1 = A | (~B & C) | (A & D) | (B & ~D) | (A & ~B & D);
        reg_F2 = (~A & B) | D;
    end

    // Asignacion para las salidas 
    assign F1 = reg_F1;
    assign F2 = reg_F2;

endmodule