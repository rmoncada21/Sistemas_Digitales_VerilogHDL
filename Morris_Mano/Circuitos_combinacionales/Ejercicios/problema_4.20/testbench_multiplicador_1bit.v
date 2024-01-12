module testbench_multiplicador_1bit;
    reg select;
    reg [3:0] In;
    wire [3:0] F;

    // Instanciar el módulo multiplicador_1bit
    multiplicador_1bit uut(
        .F(F),
        .select(select),
        .In(In)
    );

    // Task para simplificar las pruebas
    task run_test(input reg sel, input reg [3:0] input_data);
        select = sel;
        In = input_data;
        #10 $display("Resultado (select=%b, In=%b): %b", select, In, F);
    endtask

    // Inicialización y ejecución de pruebas
    initial begin
        // Caso 1: select = 0
        run_test(0, 4'b1010);

        // Caso 2: select = 1
        run_test(1, 4'b1010);

        // Caso 3: select = 0, In = 0
        run_test(0, 4'b0000);

        // Caso 4: select = 1, In = 0
        run_test(1, 4'b0000);

        // Caso 5: select = 0, In = 15
        run_test(0, 4'b1111);

        // Caso 6: select = 1, In = 15
        run_test(1, 4'b1111);

        // Puedes agregar más casos de prueba según tus necesidades

        // Finalizar la simulación
        #10 $finish;
    end
endmodule

