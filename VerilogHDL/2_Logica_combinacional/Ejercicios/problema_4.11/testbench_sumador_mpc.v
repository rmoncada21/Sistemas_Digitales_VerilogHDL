module testbench_sumador_mpc;
    // Entradas y salidas del testbench
    reg [3:0] ABCD_tb;
    reg [4:0] Suma_tb;

    // Entradas y salidas para las tareas
    reg [3:0] values [0:15];

    // Instanciar modulo
    sumador_mpc uut(
        .ABCD(ABCD_tb),
        .Suma(Suma_tb)
    );

    // Tareas del testbench
    // gen_values - mostrar_values - put-values - mostrar_entrada_salida - verify

    task gen_values;
        $display("Tabla con los posibles valores de entrada ");
        for(int i=0; i<=15; i++) begin
            values[i] = i;
        end
    endtask

    task mostrar_values;
        $display("ABCD");
        for(int i=0; i<=15; i++) begin
            $display("%4b", values[i]);
        end
    endtask

    task put_values;
        // Generar numeros random
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,15);

        // poner valores de values en ABCD
        ABCD_tb = values[opcion_random];
        //tiempo para cargar los datos
        #10;
    endtask

    task mostrar_entrada_salida;
        $display("Entrada= %4b | %4b =Salida",ABCD_tb, Suma_tb);
    endtask

    task verify;
        reg [4:0] suma_task;
        suma_task = ABCD_tb+1;

        if(Suma_tb==suma_task)begin
            $display("Prueba correcta: Salida %4b=%4b suma", Suma_tb, suma_task);
        end else begin
            $display("Prueba correcta: Salida %4b!=%4b suma", Suma_tb, suma_task);
        end

        suma_task = 0;
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

        // 4'b0001: 4'b0010
        // 4'b0010: 4'b0011
        // 4'b0011: 4'b0100
        // 4'b0100: 4'b0101
        // 4'b0101: 4'b0110
        // 4'b0110: 4'b0111
        // 4'b0111: 4'b1000
        // 4'b1000: 4'b1001
        // 4'b1001: 4'b1010
        // 4'b1010: 4'b1011
        // 4'b1011: 4'b1100
        // 4'b1100: 4'b1101
        // 4'b1101: 4'b1110
        // 4'b1110: 4'b1111
        // 4'b1111: 5'b10000