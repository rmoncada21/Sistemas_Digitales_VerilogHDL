
`timescale 1ns/1ps

module testbench_mux2x1;
    // entradas del mux
    reg [1:0] in_test;
    // inicializando los valores de los inputs
    reg [1:0] values_in_test [0:3];
    // Entrada de seleccion 1 bit
    reg sel_test;
    wire Y;

    mux2x1 uut(
        .i0(in_test[0]), 
        .i1(in_test[1]), 
        .S(sel_test), 
        .Y(Y)
    );
    
    // tarea para inicializar los valores de values_in_test
    task gen_values_in_test;
        $display("Valores predeterminados del vector values_in_test");
        $display("I0 I1");
        for (int i = 0; i <= 3; i = i + 1) begin 
            values_in_test[i] = i;
            $display("%b  %b", values_in_test[i][0], values_in_test[i][1]);
            $display("-------");
        end
    endtask

    task test_mux;
        reg [1:0] poscision_random;
        // ver el valor de select
        sel_test = $urandom_range(0, 1);
        $display("-------");
        $display("sel_test %b ", sel_test);
        // asignar las entradas input del mux
        poscision_random = $urandom_range(0, 3);
        in_test = values_in_test[poscision_random];
        #100;; // Esperar un ciclo para que se actualicen las salidas
        $display("in_test %2b, Y = %b", in_test, Y);

        // Comprobar el resultado
        if ((sel_test == 1'b0 && Y == in_test[0]) || (sel_test == 1'b1 && Y == in_test[1])) begin
            $display("Prueba pasada con éxito");
        end else begin
            $display("Error en la prueba");
        end
    endtask

    initial begin
        $dumpfile("testbench_mux2x1.vcd");
        $dumpvars(0, testbench_mux2x1);
        gen_values_in_test;
        repeat(11) begin
            test_mux;
            #100;
        end
        $finish;
    end

    // Prueba manual

    // initial begin
    //     $dumpfile("testbench_mux2x1.vcd");
    //     $dumpvars(0, testbench_mux2x1);

    //     in_test[0] = 0; in_test[1] = 0; sel_test = 0;
    //     #100;
    //     in_test[0] = 0; in_test[1] = 1; sel_test = 1;
    //     #100;
    //     in_test[0] = 1; in_test[1] = 0; sel_test = 1;
    //     #100;
    //     in_test[0] = 1; in_test[1] = 1; sel_test = 0;
    //     #100;
    //     in_test[0] = 0; in_test[1] = 0; sel_test = 1;
    //     #100;
    //     in_test[0] = 0; in_test[1] = 1; sel_test = 0;
    //     #100;
    //     in_test[0] = 1; in_test[1] = 0; sel_test = 0;
    //     #100;
    //     in_test[0] = 1; in_test[1] = 1; sel_test = 1;
    // end
    // initial
    //     $monitor("int_test[0]:%b  int_test[1]:%b  sel_test:%b  Salida:%b", in_test[0], in_test[1], sel_test, Y);

endmodule
