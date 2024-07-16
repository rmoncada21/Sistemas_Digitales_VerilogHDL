module bool_circuit(A,B,C,D,x,y);
    input A,B,C,D;
    output x,y;

    // Se procede a describir el circuito_simple
    // usando operadores logicos y el comando assign
    
    // salida x
    assign x = A | (B & C) | (~B & D);
    assign y = (~B & C) | (B & ~C & ~D);
    
endmodule