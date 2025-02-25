module testbench_semi_restador_mpc;
    // Vectores de entrada del testb
    reg [1:0] xy_tb;
    reg [1:0] PR_tb;

    // Vectores para las tareas
    reg [1:0] values [3:0];

    // Instanciar el modulo
    semi_restador_mpc uut(
        .x_(xy_tb[1]),
        .y_(xy_tb[0]),
        .P(PR_tb[1]),
        .R(PR_tb[0])
    );

    // Tareas del testbench 
    // gen_values - mostrar_values - put_values - mostrar_entrada_salida - verify
    
    task gen_values;
        for (int i=0; i<=3; i++) begin
            values[i]=i;
        end
    endtask

    task mostrar_values;
        $display("Tabla con los posibles valores de entrada ");
        $display("xy ");
        for (int i=0; i<=3; i++) begin
            $display("%b", values[i]);
        end
    endtask

    task put_values;
        // Generar numero random
        reg [1:0] opcion_random;
        opcion_random = $urandom_range(0,3);

        // colocar valores en las entrada
        xy_tb = values[opcion_random];
        // tiempo para cargar datos
        #10;
    endtask

    task mostrar_entrada_salida;
        $display("Entrada %b -> %B Salida ", xy_tb, PR_tb);
    endtask

    task verify;
        case(xy_tb)
            2'b00: 
                if(PR_tb == 2'b00) begin
                    $display("Prueba correcta Salida = 2'b00");
                end else begin
                    $display("ERROR Salida != 2'b00");
                end
            2'b01: 
                if(PR_tb == 2'b11) begin
                    $display("Prueba correcta Salida = 2'b11");
                end else begin
                    $display("ERROR Salida != 2'b11");
                end
            2'b10: 
                if(PR_tb == 2'b01) begin
                    $display("Prueba correcta Salida = 2'b01");
                end else begin
                    $display("ERROR Salida != 2'b01");
                end
            2'b11: 
                if(PR_tb == 2'b00) begin
                    $display("Prueba correcta Salida = 2'b00");
                end else begin
                    $display("ERROR Salida != 2'b00");
                end
            default:
                $display("Valores de entrada incorrectos");
        endcase
    endtask

    initial begin
        gen_values;
        mostrar_values;
        repeat(10) begin
            put_values;
            mostrar_entrada_salida;
            verify;
            $display(" ");
        end
    end
endmodule