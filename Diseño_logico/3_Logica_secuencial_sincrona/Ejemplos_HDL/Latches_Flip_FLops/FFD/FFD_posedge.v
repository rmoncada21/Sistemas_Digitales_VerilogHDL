// Ejemplo 5.2 Modelado por comportamiento
module FFD_posedge(
    output reg qd,
    input clk, data
);

    always @ (posedge clk) begin
        // Asignacion bloqueante
        qd <= data;
    end

endmodule