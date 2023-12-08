//Libro Morris Mano pag 104
//Circuit especificado con expresiones booleanas 

module bool_circuit (x,y,A,B,C,D);
    input A,B,C,D;
    output x,y;

    /*  &: compuerta and 
        |: compuerta OR
        ~: not 
    */
    assign x = A | (B & C) | (~B & D);
    assign y = (~B & C) | (B & ~C & ~D);

endmodule