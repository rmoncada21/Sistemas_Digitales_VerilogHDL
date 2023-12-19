// Descripción de flujo de datos de un comparador de 4 bits

module comparador4bits (A, B, ALTB, AGTB, AEQB);
    input [3:0] A, B;
    output ALTB, AGTB, AEQB;
    
    assign ALTB = (A<B),
           AGTB = (A>B),
           AEQB = (A==B);
endmodule