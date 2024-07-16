module testbench_mux4x1;
    // Vectores de entrada y salida del testbench
    reg Select_tb;
    reg [3:0] I0_tb, I1_tb;
    reg [3:0] F_tb;

    // Vectores para las tareas
    reg [3:0] values [15:0];
    // Instanciar el modulo
    mux4x1_mnc uu(
        .Select(Select_tb),
        .I0(I0_tb),
        .I1(I1_tb),
        .F(F_tb)
    );

    // Tareas del testbench
    // gen_values - mostrar_values - put_values - mostrar_entrada_salida - verify

    task gen_values;
        for(int i=0; i<=15; i++) begin
            values[i]=i;
        end
    endtask

    task mostrar_values;
        $display("Tabla de verdad con los posibles valores de entrada ");
        $display("ABCD");
        for(int i=0; i<=15; i++) begin
            $display("%b", values[i]);
        end
    endtask

    task put_values;
        // Generar numeros random
        reg [3:0] opcion_random;
        reg [1:0] select_random;
        
        // Poner valores en las entradas
        select_random = $urandom_range(0,1);
        Select_tb =  select_random;
        
        opcion_random = $urandom_range(0,15);
        I0_tb = opcion_random;
        
        opcion_random = $urandom_range(0,15);
        I1_tb = opcion_random;

        // tiempo para cargar los datos 
        #10;
    endtask

    task mostrar_entrada_salida;
        $display("Valores de entrada I0=%b", I0_tb);
        $display("Valores de entrada I1=%b", I1_tb);
        $display("Select=%b ", Select_tb);
        $display("Valores de salida F=%b", F_tb);
    endtask

    task verify;
        case (Select_tb)
            0:  
                if(F_tb == I0_tb) begin
                    $display("Prueba Correcta F_tb == I0");
                end else begin
                    $display("ERROR F_tb != I0");
                end
            1:
                if(F_tb == I1_tb) begin
                    $display("Prueba Correcta  F_tb == I1");
                end else begin
                    $display("ERROR F_tb != I1");
                end
            default: 
                $display("Default");
        endcase
    endtask

    initial begin
        gen_values;
        mostrar_values;
        repeat(10) begin
            put_values;
            //mostrar_entrada_salida;
            verify;
            $display(" ");
        end
    end

endmodule