// Ejemplo HDL 4.2.1
// Descripcion HDL usando el tipo de datos "tri" para la salida
module tri_mux2x1 (A,B,select,OUT);
    input A, B, select;
    output OUT;
    tri OUT;
    bufif1 (OUT, A, select);
    bufif0 (OUT, B, select);
endmodule
