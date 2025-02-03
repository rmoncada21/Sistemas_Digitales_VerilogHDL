`include "FFD_reset_async.v"

module testbench_FFD_reset_async;
    // Vectores de entrada y salida del testb    
    wire qd_tb;
    reg clk_tb, data_tb, reset_async_tb;

    // Vectores para las tareas

    // Instanciación del modulo
    FFD_reset_async uut(
        .qd(qd_tb),
        .clk(clk_tb),
        .data(data_tb),
        .reset_async(reset_async_tb)
    );

    // Tareas

    // Generar el archivo de ondas 
    task gen_vcd_file;
        $dumpfile("testbench_FFD_reset_async");
        // 0: No incluir ninguna variable en el archivo de volcado.
        // 1: Incluir todas las variables en el archivo de volcado.
        $dumpvars(1, testbench_FFD_reset_async);
    endtask

    // Verificar el funcionamiento del circuito
    task verify();
        case(reset_async_tb)
        0:
            $display("Reset BUTTOM pushed");
        1:
            if(qd_tb==data_tb) begin
                $display("Correcto b");
            end else begin
                $display("ERROR b");
            end

        endcase
    endtask

    // Generar el ciclo del reloj
    always #5 clk_tb = ~clk_tb;
    
    // Verificar los flancos de subida
    always @(posedge clk_tb or reset_async_tb) begin
        #0.5
        verify();
    end

    // always @ (posedge clk_tb) begin
    //     $display("Clk=%b Reset=%b Data=%b Q=%b tiempo=%0dns",clk_tb, reset_async_tb, data_tb, qd_tb, $time);
    // end 

    initial begin
        gen_vcd_file;

        $monitor("Clk=%b Reset=%b Data=%b Q=%b tiempo=%0dns",clk_tb, reset_async_tb, data_tb, qd_tb, $time);
        // Inicializar los valores de entrada
        clk_tb = 0; data_tb = 0;
        // reset = 0 deshabilita el circuito 
        // y la salida siempre es 0
        reset_async_tb = 0; #5;
        // Habilita el circuito
        reset_async_tb = 1;
        // Una vez habilitado el circuito, se dan las entradas

        // Generar los valores de entrada aleatorios
        repeat(5) begin
            data_tb = $urandom_range(0,1); #5;
        end

        reset_async_tb = 0; #5;
        // Habilita el circuito
        reset_async_tb = 1;

        // Generar los valores de entrada aleatorios
        repeat(5) begin
            data_tb = $urandom_range(0,1); #5;
        end

        $finish;
    end
    
endmodule