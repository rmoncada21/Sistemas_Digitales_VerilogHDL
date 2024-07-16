module testbench_mux2x1_mpc;
    // Entradas y salidas del testbench
    reg [0:1] in_tb;
    reg select_tb;
    wire y_tb;
    
    // vectores para las tareas
    reg [0:1] in_task [0:3];

    // Instanciar el circuito mux2x1
    mux2x1_mpc uut(
        .i0(in_tb[0]),
        .i1(in_tb[1]),
        .select(select_tb),
        .y(y_tb)
    );

    // Tarea para generar las entradas input del test in_tb
    task gen_values_in_tb;
        $display("Tabla con los valores de entrada ");
        $display("i0  i1");

        for(int i=0; i<=3; i=i+1) begin
            in_task[i] = i;
            $display("%b   %b", in_task[i][0], in_task[i][1]);
        end
    endtask

    task verify_mux_behavior;
        reg [0:1] poscision_random;
        poscision_random = $urandom_range(0,3);
        // se obtiene la entrada
        in_tb = in_task[poscision_random];
        // obtener entrada de selección
        select_tb = $urandom_range(0,1);
        #10;

        // observar las entradas al mux 
        $display("\nVectores para las entradas");
        $display("i0  i1 | S   Y");
        $display("%b    %b | %b   %b", in_tb[0], in_tb[1], select_tb, y_tb);
        
        // verificar funcionamiento
        if ((select_tb == 0 && in_tb[0] == y_tb) | (select_tb == 1 && in_tb[1] == y_tb)) begin
            $display("Prueba exitosa");
        end else begin
            $display("Error en la prueba");
        end

    endtask

    initial begin
        gen_values_in_tb;
        repeat(15) begin
            verify_mux_behavior;
        end
        $finish;
    end
endmodule