// Ejemplos 5.3 a)
module FFT_with_FFD_and_gates(
    output qt,
    input clk, T, reset
);
    wire D;
    assign D = T ^ qt;

    // Instanciat el FFD
    FFD_reset_async FFD (qt, clk, D, reset);

endmodule