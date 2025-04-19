// `timescale 1ns/1ps

module circuito_nosimp_mnc(input A, B, C, D, output F, G);
    wire anot, T1, T2, T3, T4;

    not 
        not1(anot, A);
    and 
        and4(T4, B, C),
    // compueranots de salidas
        andF(F, T1, T2),
        andC(G, T2, T3);
    nand 
        nand1(T1, anot, T3),
        nand3(T3, anot, D);
    or 
        or2(T2, anot, T4);
endmodule