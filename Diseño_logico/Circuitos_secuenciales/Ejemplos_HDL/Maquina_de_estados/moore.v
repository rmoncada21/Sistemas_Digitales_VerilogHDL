// Ejemplo 5.6 Diagrama de estados de moore

module Moore_mdl (
    // AB estado de salida
    output [1:0] AB, 
    input x,CLK,RST
);

    reg [1:0] state;    
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    
    always @ (posedge CLK or negedge RST)
        if (~RST) state = S0; //Iniciar en estado S0
        else
        case (state)
        S0: if (~x) state = S1; else state = S0;
        S1: if (x) state = S2; else state = S3;
        S2: if (~x) state = S3; else state = S2;
        S3: if (~x) state = S0; else state = S3;
        endcase

    assign AB = state; //Salida de flip-flops

endmodule