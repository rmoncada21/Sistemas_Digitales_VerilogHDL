module semi_restador_mpc(
    // Dos numeros de un bit cada uno
    input x_, y_,
    // P: prestamo R: Resta
    output reg P, R
);

    // Modelado por comportamiento
    always@(*) begin
        case({x_, y_})
            2'b00: {P, R} = 2'b00;
            2'b01: {P, R} = 2'b11;
            2'b10: {P, R} = 2'b01;
            2'b11: {P, R} = 2'b00;
        endcase
    end
    
endmodule