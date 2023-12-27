// mux 2x1 en modelado por nivel de compuertas

module mux2x1(i0, i1, S, Y);
    input i0, i1, S;
    output Y;
    wire w0, w1, Snot;

    not (Snot, S);
    and
        and1 (w0, i0, Snot),
        and2 (w1, i1, S);
    or
        or1 (Y, w0, w1);
endmodule
