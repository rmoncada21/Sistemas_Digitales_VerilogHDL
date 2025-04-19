// `include "load_control.v"

module FFD(
    input reloj, D,
    output reg An
);

    // variables para conexion de modulos

    // implementar lógica de FFD
    always @(posedge reloj) begin
        An <= D;
    end

endmodule