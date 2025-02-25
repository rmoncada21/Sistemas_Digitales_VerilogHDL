module testbench_complemento_9_BCD_mnc;
    // Entradas y salidas del tesbench
    reg [3:0] A_tb;
    reg [3:0] Complemento_tb;

    // Vectores para las tareas
    reg [3:0] values [0:15];
    // Instanciar el modulo
    complemento_9_BCD uut(
        .A(A_tb),
        .Complemento(Complemento_tb)
    );

    // Tareas del testbench
    // gen_values - mostrar_values - put_values_in - mostrar_entrada_salida - verify

    task gen_values;
        for(int i=0; i<=15; i++) begin
            values[i]=i;
        end
    endtask

    task mostrar_values;
        $display("Tabla con lo posibles valores de entrada del modulo ");
        $display("3210 A");
        for(int i=0; i<=15; i++) begin
            $display("%b", values[i]);
        end
    endtask

    task put_values;
        // Generar numero random
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,9);

        // poner valores dentro del vector de entrada
        A_tb = values[opcion_random];
        
        // tiempo para cargar los datos
        #10;
    endtask

    task verify;
        reg [3:0] complemento_task;

        complemento_task = 4'b1001-A_tb;
        
        if(Complemento_tb == complemento_task) begin
            $display("Prueba correcta, el complemento a de A=%b es %b", A_tb, Complemento_tb);
        end else begin
            $display("ERROR, el complemento a de A=%b no es %b", A_tb, Complemento_tb);
        end
    endtask

    initial begin
        gen_values;
        repeat(20) begin
            put_values;
            verify;
        end
    end

endmodule
