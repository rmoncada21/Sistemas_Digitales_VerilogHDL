module tb_display_numero_ocho;
    reg clk;
    wire a, b, c, d, e, f, g;

    // Instanciación del módulo
    display_numero_ocho uut(
        .clk(clk),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g)
    );

    // Generar un reloj
    initial begin
        clk = 1;
        forever #5 clk <= ~clk;  // Usa <= en lugar de =
    end

    // Simulación de 40 unidades de tiempo
    initial #200 $finish;
    // Mostrar los resultados
    always @(posedge clk) begin
        $display("a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b", a, b, c, d, e, f, g);
    end
endmodule