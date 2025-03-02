// Ejemplo HDL 4.8
// Descripción de comportamiento del multiplexor 4 a 1
// Desscribe la tabla de función de la figura

module mux4x1(i0, i1, i2, i3, select, y);
    input i0, i1, i2, i3;
    input [1:0] select;
    output y;
    reg y;

    always @(i0 or i1 or i2 or i3 or select)
        case (select)
            2'b00: y = i0;
            2'b01: y = i1;
            2'b10: y = i2;
            2'b11: y = i3;
        endcase
endmodule