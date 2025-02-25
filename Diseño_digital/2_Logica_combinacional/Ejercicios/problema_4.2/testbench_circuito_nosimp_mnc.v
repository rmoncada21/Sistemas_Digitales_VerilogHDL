
module testbench_circuito_nosimp_mnc;
    reg [3:0] in;
    wire F, G;

    circuito_nosimp_mnc uut (
        .A(in[3]),
        .B(in[2]),
        .C(in[1]),
        .D(in[0]),
        .F(F),
        .G(G)
    );

    // Definición de la tarea para generar la tabla de verdad
    task gen_table;
        reg [3:0] in_func;
        $display("testbench_circuito_nosimp_mnc");
        $display("A B C D| F G");

        // Iterar sobre todas las combinaciones posibles
        repeat (16) begin
            in_func = in;
            #10;  // Esperar un ciclo antes de mostrar el resultado
            $display("%b %b %b %b| %b %b", in_func[3], in_func[2], in_func[1], in_func[0], F, G);
            in = in + 1;  // Incrementar la entrada para la próxima iteración
        end

        // Finalizar la simulación
        $finish;
    endtask

    // Llamada a la tarea para generar la tabla de verdad
    initial begin
        in = 4'b0000;
        gen_table;
    end

endmodule
