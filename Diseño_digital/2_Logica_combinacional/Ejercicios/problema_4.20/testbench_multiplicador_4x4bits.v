module testbench_multiplicador_4x4bits;
    // Vectores de entrada y salida del tesbbench
    wire [7:0] M_tb;
    reg [3:0] xm_tb, ym_tb;
    
    // Vectores para las entradas
    reg [3:0] values [0:15];
    // Instanciar los modulos para la prueba
    multiplicador_4x4bits uut(
        .M(M_tb),
        .xm(xm_tb),
        .ym(ym_tb)
    );

    // Tareas para el test
    // gen_values - mostrar_values - put_values - mostrar_entrada_salida - verify

    task gen_values;
        for(int i=0; i<=15; i++) begin
            values[i] = i;
        end
    endtask

    task mostrar_values();
        $display("Posibles valores de entrada \n ABCD ");
        for(int i=0; i<=15; i++) begin
            $display(" %b", values[i]);
        end
    endtask

    task put_values();
        // Generar numeros random 
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,15);
        xm_tb = opcion_random;
        opcion_random = $urandom_range(0,15);
        ym_tb = opcion_random;

        // Tiempo para cargar los datos en las entrads
        #10;
    endtask

    task verify();
        reg [7:0] multiplicacion_task;
        multiplicacion_task = xm_tb * ym_tb;
        $display("Multi %d", multiplicacion_task);

        if(M_tb == multiplicacion_task) begin
            $display("Prueba CORRECTA X=%d  *  Y=%d = %d", xm_tb, ym_tb, M_tb);
        end else begin
            $display("ERROR");
        end
    endtask

    initial begin
        gen_values;
        mostrar_values;
        repeat(20) begin
            put_values;
            verify;
            $display("");
        end
    end
endmodule