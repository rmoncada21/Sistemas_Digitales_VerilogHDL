`include "FFT_posedge_reset_async.v"

 module testbench_FFT_posedge_reset_async;
    // Entradas y salidas de testbench
    wire Q_tb;
    reg clk_tb, T_tb, reset_async_tb;

    // Vectores para las tareas
    reg Q_prev;

    // Instanciar el modulo
    FFT_posedge_reset_async uut(
        .Q(Q_tb),
        .clk(clk_tb),
        .T(T_tb),
        .reset_async(reset_async_tb)
    );

    // Tareas del sistema

    // Generar archivos de onda
    task gen_vcd_file();
        $dumpfile("testbench_FFT_posedge_reset_async");
        $dumpvars(1, testbench_FFT_posedge_reset_async);
    endtask

    // Tarea de verificación 
    task verify_FFT(reg Q_prev);
        case(T_tb)
        1'b0:
            if(Q_tb == Q_prev) begin
                $display("Correcto Q(t+1)=Q(t)");
            end else begin
                $display("ERROR Q(t+1)!=Q(t)");
            end
        1'b1:
            if(Q_tb == (~Q_prev)) begin
                $display("Correcto Q(t+1)=Q(t)");
            end else begin
                $display("ERROR Q(t+1)!=Q(t)");
            end
            
        endcase
    endtask

    // Iniciar el clk 
    always #5 clk_tb = ~clk_tb;

    // Verificar en los flancos de subida
    always @ (posedge clk_tb) begin
        // Capturar la salida de un qire a un reg
        reg captura;
        assign captura = Q_tb & 1;
        Q_prev <= captura;
        // Retardo necesatio para verificar los correctos valores en las estados
        #0.5;
        if(reset_async_tb) begin
           verify_FFT(Q_prev); 
        end else begin
            $display("PRESH RESET BUTTOM");
        end
    end

    initial begin
        gen_vcd_file;
        // Inicilizar los valores de entrada
        $monitor("CLK=%b T=%b Q=%b tiempo=%0dns", clk_tb, T_tb, Q_tb, $time);
        clk_tb = 0; T_tb=0;
        
        reset_async_tb = 0;
        #5; reset_async_tb = 1;

        repeat(10) begin
            #5 T_tb = $urandom_range(0,1);
        end

        reset_async_tb = 0;
        #5; reset_async_tb = 1;

        repeat(10) begin
            #5 T_tb = $urandom_range(0,1);
        end
        $finish;
    end
 endmodule