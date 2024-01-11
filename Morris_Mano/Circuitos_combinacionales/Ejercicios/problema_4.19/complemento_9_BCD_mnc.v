module complemento_9_BCD(
    output reg [3:0] Complemento,
    input reg [3:0] A
);

    wire
        // Negados
        notA3, notA2, notA1, notA0,
        // Entradas 
        A3, A2, A1, A0;
    buf
        b3(A3, A[3]), b2(A2, A[2]), b1(A1, A[1]), b0(A0, A[0]),
        // Salida C1
        bC1(Complemento[1], A1),
        bC0(Complemento[0], notA0);
        

    not
        n3(notA3, A3), n2(notA2, A2), n1(notA1, A1), n0(notA0, A0);
        // Salida
        // notC0(Complemento[0], A0);

    and
        and1(Complemento[3], notA3, notA2, notA1);
    
    xor
        xor1(Complemento[2], A2, A1);

endmodule