// Ejemplo 5.1
// Modelado por nivel de comportamiento
module latchD_control_in(
    output reg qd,
    input control, data
);

    always @ (control or data) begin
        // si control es igual a 1
        if (control) qd = data;
    end
endmodule