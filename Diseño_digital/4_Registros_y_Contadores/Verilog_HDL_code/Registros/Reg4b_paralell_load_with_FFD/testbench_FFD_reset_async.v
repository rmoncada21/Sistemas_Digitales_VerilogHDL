`include "FFD_reset_async.v"

module testbench_FFD_reset_async;
    // Puertos de entrada y saida
    reg clk, d, reset_async;
    wire q;

    // Variables y vectores para el test

    // Instanciación del circuito; uut/dut
    FFD_reset_async uut(
        .q(q),
        .clk(clk),
        .d(d),
        .reset_async(reset_async)
    );

    // Tareas del testbench
    task gen_vcd_file();
        $dumpfile("gtkwave/testbench_FFD_reset_async");
        $dumpvars(1, testbench_FFD_reset_async);
    endtask

    // verificar el funcionamiento del flip flop
    task verify_ffd();
        // $display("verify");
        case(reset_async)
            0:
                if(q==d) begin
                    $display("Valor correcto ");
                end else begin
                    $display("Valor incorrecto ");
                end
            1:
                $display("Reset BUTTOM pushed");
            
            default: begin
                    $display("Default value");
                    $finish;
                end
        endcase
    endtask

    // generar valores random
    task gen_values();
        d = $urandom_range(0,1);
    endtask

    // resetear el FF en el tiempo = 25

    // generar señal de reloj
    always #5 clk = ~ clk;

    // verificar en flancos positivos
    always @(posedge clk or reset_async) begin
        #0.5
        // gen_values();
        verify_ffd();
    end

    // bloque initial
    initial begin
        // generar formas de onda de salida
        gen_vcd_file();
        
        // monitorear datos
        $monitor("Time = %0t, clk = %b, reset_async = %b, d = %b, q = %b", $time, clk, reset_async, d, q);
        
        // inicilizar los valores
        clk = 0; reset_async = 1; d = 0;
        #5; reset_async = 0;

        repeat(10)begin
            gen_values();
            
            if($time == 25) begin
                reset_async = 1;
            end

            #5; reset_async = 0;
        end

        $finish;
    end
endmodule