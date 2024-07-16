`timescale 1ns/1ps

module testbench_mux2x1_mfd;

    // Entradas y salidas del testbench
    reg [0:1] in_tb;
    wire y_tb;
    reg sel_tb;

    // Vector para la tarea gen_values_in_tb
    reg [0:1] in_test [0:3];

    // Instancia del módulo bajo prueba
    mux2x1_mfd uut (
        .i0(in_tb[0]),
        .i1(in_tb[1]),
        .S(sel_tb),
        .Y(y_tb)
    );

    // Tarea para generar las entradas input
    task gen_values_in_tb;
        // Vector tipo matriz equivalente a una tabla de verdad de 4 posiciones
        for (int i = 0; i <= 3; i = i + 1) begin
            in_test[i] = i;
            $display("in_test[%0d] = %b: ", i, in_test[i]);
        end
    endtask

    // Tarea para verficar los resultados
    task verficar_mux;
        reg [0:1] opcion_random;

        // Generar entradas del selector con la funcion random
        sel_tb = $urandom_range(0, 1);
        $display("-------");
        $display("sel_tb %b ", sel_tb);

        // Obtener las entradas del in_tes de formar random a partir del 
        // vector tipo matriz reg [0:1] in_test [0:3];
        opcion_random = $urandom_range(0, 3);
        in_tb = in_test[opcion_random];
        #100;
        // Es importante darle tiempo al programa para que cargue los datos
        $display("in_tb %2b, Y = %b", in_tb, y_tb);

        // Parte de selección de errores
        if ((sel_tb == 1'b0 && in_tb[0] == y_tb ) || (sel_tb == 1'b1 && in_tb[1] == y_tb )) begin 
            $display("Prueba exitosa ");
        end else begin
            $display("ERROR ");
        end
    endtask

    // Iniciar la ejecución, similar al main
    initial begin
        $dumpfile("testbench_mux2x1_mfd.vcd");
        $dumpvars(0, testbench_mux2x1_mfd);
        gen_values_in_tb;
        repeat(7) begin
            verficar_mux;
        end 
    end

endmodule
