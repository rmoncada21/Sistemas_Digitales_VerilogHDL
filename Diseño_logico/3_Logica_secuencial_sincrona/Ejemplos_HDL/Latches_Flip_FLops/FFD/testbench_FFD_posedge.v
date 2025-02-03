`include "FFD_posedge.v"

module testbench_FFD_posedge;
    // ENtradas y salidas del test
    wire Q_tb;
    reg clk_tb, data_tb;

    // Instanciación del modulo
    FFD_posedge uut(Q_tb, clk_tb, data_tb);

    // Tareas del test 

    task gen_vcd_file;
        $dumpfile("testbench_FFD_posedge");
        $dumpvars(1, testbench_FFD_posedge);
    endtask

    // Generar el reloj
    always #5 clk_tb = ~clk_tb;

    always @ (posedge clk_tb) begin
        #0.5
        if(data_tb==Q_tb) begin
            $display("Correcto");
        end else begin
            $display("Error");
        end
    end



    initial begin
        gen_vcd_file;
        $display("FFD testbench");
        // Monitorear los valores en cada cambio
        $monitor("Clk=%b Data=%b Q=%b tiempo=%0dns",clk_tb, data_tb, Q_tb, $time);
        // Inicializar los valores
        clk_tb = 0;
        data_tb = 0; 

        repeat(10) begin
            data_tb = $urandom_range(0,1);
            #5;
        end
        $finish;
    end
    
endmodule