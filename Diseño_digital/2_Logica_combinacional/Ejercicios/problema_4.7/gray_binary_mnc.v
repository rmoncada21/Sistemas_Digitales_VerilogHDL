module gray_binary_mnc(
    // Entradas y salidas del circuito
    input reg [3:0] GRAY,
    output reg [3:0] wxyz
);
    // Modelado del circuito
    buf 
        b1(wxyz[3], GRAY[3]);

    xor
        xor1 (wxyz[2], GRAY[3], GRAY[2]),
        xor2 (wxyz[1], wxyz[2], GRAY[1]),
        xor3 (wxyz[0], wxyz[1], GRAY[0]);

endmodule

