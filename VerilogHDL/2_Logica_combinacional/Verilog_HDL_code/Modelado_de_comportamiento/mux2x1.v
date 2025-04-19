// Ejemplo HDL 4.7
// Descripción de comportamiento de un multiplexor 2x1

module mux2x1 (A , B, select, OUT);
    input A, B, select;
    output OUT;
    reg OUT;
    always @ (select or A or B )
        if (select == 1) OUT = A;
        else OUT = B;
endmodule