// Modelado por dlujo de datos con assign

module mux2x1_mfd(i0, i1, S, Y);
    input i0, i1, S;
    output Y;

    assign Y = (i0 & ~S) | (i1 & S);
endmodule