// Ejemplo 5.5 Maquinas de estados MEALY

module mealy(
    output reg y,
    input x, clk, rst
);
    // El estado de los flip-flops se
    // declara con los identificadores 
    // Acstate (estado actual) y Nxtstate (siguiente estado)
    
    reg [1:0] Acstate, Nxtstate;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;


    /* La descripción HDL utiliza tres bloques always que se ejecutan
    de forma concurrente e interactúan a través de variables en común 
    */


    /* El primer enunciado always restablece el circuito al estado 
    inicial S0=00 y especifica la operación sincrónica con reloj */

    always @ (posedge clk or negedge rst)
        //Iniciar en estado S0
        if (~rst) Acstate = S0;
        //Operaciones de reloj
        else Acstate = Nxtstate;
    
    //Determinar siguiente estado
    always @ (Acstate or x)
        case (Acstate)
        S0: if (x) Nxtstate = S1;
            else Nxtstate = S0;
        S1: if (x) Nxtstate = S3;
            else Nxtstate = S0;
        S2: if (~x)Nxtstate = S0;
            else Nxtstate = S2;
        S3: if (x) Nxtstate = S2;
            else Nxtstate = S0;
        endcase
    
    //Evaluar salida
    always @ (Acstate or x)
        case (Acstate)
        S0: y = 0;
        S1: if (x) y = 1'b0; else y = 1'b1;
        S2: if (x) y = 1'b0; else y = 1'b1;
        S3: if (x) y = 1'b0; else y = 1'b1;
        endcase

endmodule