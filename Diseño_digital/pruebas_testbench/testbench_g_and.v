`timescale 1ns/1ps 
module testbench_g_and;

    // Entradas y salidas del testbench
    reg [1:0] in;
    wire out;

    // Instancia del módulo bajo prueba
    g_and uut (.A(in[1]), .B(in[0]), .Y(out));

    // Inicialización de las señales
    initial begin
        $display("A\tB\tY");
        in = 3'b000;
        repeat(8) begin
            #1;  // Esperar un ciclo para que se actualicen las salidas
            $display("%b\t%b\t%b", in[1], in[0], out);
            in = in + 1;  // Incrementar la entrada para la próxima iteración
        end

        // También puedes usar un bucle for para las combinaciones
        for (int i = 0; i < 4; i = i + 1) begin
            #1;
            $display("%b\t%b\t%b", in[1], in[0], out);
            in = in + 1;
        end

        $finish;  // Finalizar la simulación
    end

endmodule
