// Ejemplo 5.3 b)
`include "FFD_reset_async.v"

module FFJK(
    output Q,
    input clk, J, K, reset_async
);

    reg D;
    assign D = (J & ~Q) | (~K & Q);

    // Instanciar FFD
    FFD_reset_async FFD(
        .qd(Q),
        .clk(clk),
        .data(D),
        .reset_async(reset_async)
    );
endmodule

