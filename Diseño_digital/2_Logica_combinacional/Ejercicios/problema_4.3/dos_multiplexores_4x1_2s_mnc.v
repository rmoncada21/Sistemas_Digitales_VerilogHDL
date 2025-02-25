module dos_multiplexores_4x1_2s_mnc(A0, A1, A2, A3, B0, B1, B2, B3, S, E, Y0, Y1, Y2, Y3);
    input A0, A1, A2, A3, B0, B1, B2, B3, S, E;
    output Y0, Y1, Y2, Y3;
    wire wA0, wA1, wA2, wA3, wB0, wB1, wB2, wB3, Snot, Enot;

    // Circuito modelado por nivel de compuertas "mnc"
    not
        notS (Snot, S),
        notE (Enot, E);
    
    // hacer compuerta para entradas A and_(signal_ES_A, Snot, Enot);
    // hacer compuerta para entradas B and_(signal_ES_B, S, Enot);
    and 
        and_a0 (wA0, A0, Snot, Enot),
        and_a1 (wA1, A1, Snot, Enot),
        and_a2 (wA2, A2, Snot, Enot),
        and_a3 (wA3, A3, Snot, Enot),

        and_b0 (wB0, B0, S, Enot),
        and_b1 (wB1, B1, S, Enot),
        and_b2 (wB2, B2, S, Enot),
        and_b3 (wB3, B3, S, Enot);
    or 
        or_Y0 (Y0, wA0, wB0),
        or_Y1 (Y1, wA1, wB1),
        or_Y2 (Y2, wA2, wB2),
        or_Y3 (Y3, wA3, wB3);
endmodule
