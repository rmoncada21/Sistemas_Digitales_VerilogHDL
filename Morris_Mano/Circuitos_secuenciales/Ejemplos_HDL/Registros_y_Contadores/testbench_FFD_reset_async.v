`include "FFD_reset_async.v"

module testbench_FFD_reset_async;
    wire q_tb;
    reg clk_tb, data_tb, reset_async_tb;

    // Instanciar el modulo 
    reg Q_prev;
    FFD_reset_async FFD_rs(
        .q(q_tb),
        .clk(clk_tb),
        .data(data_tb),
        .reset_async(reset_async_tb)
    );
    
    // Tareas del testbench
    task gen_vcd_file();
        $dumpfile("testbench_FFD_reset_async");
        $dumpvars(0, testbench_FFD_reset_async);
    endtask

    // Tarea para verificar 
    task verify();
        if(q_tb == data_tb) begin
            $display("Correcto");
        end else begin
            $display("ERROR");
        end 
    endtask

    // Generar el reloj
    always #5 clk_tb = ~clk_tb;

    // Verificar en cada flanco de subida
    always @ (posedge clk_tb) begin
        #0.5;
        if (reset_async_tb) verify();
        else $display("PUSH RESET BUTTOM");
    end

    initial begin
        $monitor("Clk=%b Data=%b Q=%b tiempo=%0dns",clk_tb, data_tb, q_tb, $time);
        // Generar el archivo de salida vcd
        gen_vcd_file();
        // Inicializar los valores
        clk_tb = 0; data_tb = 0;
        reset_async_tb = 0;
        #5;
        // funcion normal del circuito 
        reset_async_tb = 1;

        repeat(10) begin
            data_tb = $urandom_range(0,1);
            #5;
        end

        reset_async_tb = 0;
        #5;    
        // funcion normal del circuito 
        reset_async_tb = 1;
        repeat(10) begin
            data_tb = $urandom_range(0,1);
            #5;
        end

        $finish;
    end
endmodule