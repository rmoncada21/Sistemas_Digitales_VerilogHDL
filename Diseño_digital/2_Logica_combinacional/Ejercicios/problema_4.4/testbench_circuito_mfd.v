module testbench_circuito_less3b;
    // Entradas y salidas del test
    reg [2:0] ABC_tb;
    wire F_tb;

    // Vectores para las tareas
    reg [2:0] values [0:7];


    // instanciar el curcuito
    circuito_less3b uut(
        .ABC(ABC_tb),
        .F(F_tb)
    );

    // Tareas para el testbench 

    // Tarea: Generar la table de verdad para las entradas
    task gen_values;
        $display("Tabla de verdad para las posibles entradas");
        $display("A  B  C  |  Y");
        for(int i=0; i<=7 ; i=i+1) begin
            values[i] = i;
            if(i<3) begin
                $display("%b  %b  %b  |  1", values[i][2], values[i][1], values[i][0]);
            end else begin
                $display("%b  %b  %b  |  0", values[i][2], values[i][1], values[i][0]);
            end
        end
    endtask

    // Tarea para poner los valores en el vector de entrada del circuito
    task put_values;
        // generar valores random
        reg [2:0] opcion_random;
        opcion_random = $urandom_range(0,7);

        // obtener el vector de values a ABC_tb
        ABC_tb = values[opcion_random];
        // Importante agregar variable de tiempo para que se carguen los datos
        #1;
        $display("---");
        $display("Valores de input ABC y salida ");
        $display("A  B  C  |  F");
        $display("%b  %b  %b  |  %b", ABC_tb[2], ABC_tb[1], ABC_tb[0], F_tb);
    endtask


    // Tarea para verificar el comportamiento del circuito
    task verify_circuit;
        if ((ABC_tb <= 3'b010 && F_tb == 1) || (ABC_tb > 3'b010 && F_tb == 0)) begin 
            $display("Prueba correcta");
        end else begin
            $display("ERROR en la prueba");
        end
    endtask

    initial begin
        gen_values;
        repeat(10) begin 
            put_values;
            verify_circuit;
            $display("---------------------------");
        end

    end
endmodule 