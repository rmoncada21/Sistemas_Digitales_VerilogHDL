// Circuito modelado por nivel de compuertas

module circuito_compuertas (A, B, C, D, F1, F2);
    input A, B, C, D;
    output F1, F2;
    wire T1, T2, T3, T4, Anot, Bnot;

    not
        not1 (Anot, A), 
        not2 (Bnot, B);
    and
        and1 (T1, Bnot, C),
        and2 (T2, Anot, B);
    xor
        xor1 (T4, T2, D);
    or
        or1 (T3, A, T1),
        or_F2 (F2, T2, D),
        or_F1 (F1, T3, T4);
endmodule