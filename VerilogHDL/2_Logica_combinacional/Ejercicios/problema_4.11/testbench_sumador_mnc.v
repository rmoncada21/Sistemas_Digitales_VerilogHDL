module testbench_sumador_completo;
    // Entrada sy salidas del testbench
    reg xtb, ytb, ztb;
    wire Suma_tb, Acarreo_tb;

    // Vectores para las tareas
    reg [2:0] values [0:8];

    // Instaciar el modulo
    sumador_completo SC(
        .x_(xtb),
        .y_(ytb),
        .z_(ztb),
        .Suma(Suma_tb),
        .Acarreo(Acarreo_tb)
    );

    // Tareas del sistema
    // gen_values - mostrar_Values - mostrar_entrada_salida - verify

    task gen_values;
        for (int i=0; i<=7; i++) begin
            values[i] = i;
        end 
    endtask

    task mostrar_values;
        $display("Tabla con los posibles valores de entrada ");
        $display("xyz   z:acarreo de entrada");
        for (int i=0; i<=7; i++) begin
            $display("%b",values[i]);
        end 
    endtask

    task put_values;
        //generar numero random
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,7);

        // encontrar valores de entrada
        xtb = values[opcion_random][2];
        ytb = values[opcion_random][1];
        ztb = values[opcion_random][0];
        #10;
    endtask

    task mostrar_entrada_salida;
        $display("Entrada %b+%b+%b=%2b Salida", xtb, ytb, ztb, {Acarreo_tb, Suma_tb});
    endtask

    task verify;
        reg [1:0 ]suma_task;
        suma_task = xtb+ytb+ztb;
        if({Acarreo_tb, Suma_tb} == suma_task) begin
            $display("Prueba correcta Salida %b = %3b Suma", {Acarreo_tb, Suma_tb}, suma_task );
        end else begin
            $display("Error ");
        end
        suma_task = 0;
        
    endtask

    initial begin
    gen_values;
    mostrar_values;
    repeat(15) begin
        put_values;
        mostrar_entrada_salida;
        verify;
        $display(" ");
    end 
    end  
endmodule