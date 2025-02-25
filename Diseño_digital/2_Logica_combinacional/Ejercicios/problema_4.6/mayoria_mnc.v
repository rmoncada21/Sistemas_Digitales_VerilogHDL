// Circuito mayoria modelado por nivel de compuertas

module mayoria_mnc(
    input reg [2:0] ABC,
    output wire F
);
    wire w1, w2, w3, A, B, C;

    assign 
        A = ABC[2],
        B = ABC[1],
        C = ABC[0];

    or 
        or1 (w1, B, C),
        or2 (F, w2, w3);

    and 
        and1 (w2, w1, A),
        and2 (w3, B, C);

endmodule 