module complementador_a_2(
    input reg [3:0] ABCD,
    output reg [3:0] wxyz
);
    // Modelado por nivel de compuertas
    wire
        wor1, wor2, A, B, C, D, w, x_, y;

    buf
        bA(A, ABCD[3]), bB(B, ABCD[2]), bC(C, ABCD[1]), bD(D, ABCD[0]),
        bw(wxyz[3], w), bx(wxyz[2], x_), by(wxyz[1], y), bz(wxyz[0], D);

    or
        or1(wor1, B, C, D),
        or2(wor2, C, D);

    xor
        xorw(w, wor1, A),
        xorx(x_, wor2, B),
        xory(y, C, D);

    initial begin
        $display("Complementador a 2 done");
    end
endmodule