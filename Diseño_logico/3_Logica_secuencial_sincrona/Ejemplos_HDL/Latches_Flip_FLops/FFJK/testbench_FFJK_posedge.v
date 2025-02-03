`include "FFJK_posedge.v"

module testbench_FFJK_posedge;
    wire Q_tb, Qnot_tb;
    reg J_tb, K_tb, clk_tb, reset_async_tb;

    // Instanciar el modulo 
    reg Q_prev;
    FFJK_posedge uut(Q_tb, Qnot_tb, J_tb, K_tb, clk_tb, reset_async_tb);

    // Tareas para el testbench
    task gen_vcd_file;
        $dumpfile("testbench_FFJK_posedge");
        $dumpvars(1, testbench_FFJK_posedge);
    endtask
    
    // Generar clock
    always #5 clk_tb = ~clk_tb;

    // Tabla de verdad FF JK
    // J K | Q(t+1)
    // ----|-------
    // 0 0 | Q(t)     
    // 0 1 | 0     
    // 1 0 | 1     
    // 1 1 | Toggle

    task verify_FFJK(reg Q_prev);
        case({J_tb,K_tb})
        2'b00:
            if(Q_tb == Q_prev) begin
                $display("Correcto Q(t+1) = Q(t)");
            end else begin
                $display("ERROR Q(t+1)!=Q(t)  ");
            end
        2'b01:
            if(Q_tb == 1'b0) begin
                $display("Correcto Q(t+1) = 0 RESET");
            end else begin
                $display("ERROR Q(t+1)!=0 JK=%b%b", J_tb, K_tb);
            end
        2'b10: 
            if(Q_tb == 1'b1) begin
                $display("Correcto Q(t+1) = 1 SET");
            end else begin
                $display("ERROR Q(t+1)!=1  JK=%b%b Q=%b tiempo=%0dns", J_tb, K_tb, Q_tb, $time);
            end
        2'b11:
            if(Q_tb == (~Q_prev)) begin
                $display("Correcto Q(t+1) = ~Q(t)");
            end else begin
                $display("ERROR Q(t+1)!= ~Q(t) JK=%b%b", J_tb, K_tb);
            end
        default: $display("VALOR DEFAULT X/Z JK=%b%b", J_tb, K_tb);
        endcase
    endtask

    always @(posedge clk_tb) begin
        // captura el valor pasado de la salida
        reg capturar;
        assign capturar = Q_tb & 1;
        Q_prev <=  capturar;
        #0.5;
        $display("\n");

        if(reset_async_tb) begin
            verify_FFJK(Q_prev);
        end else if(Q_tb==1'b0) begin
            $display("PUSH RESET BUTTOM");
            $display("Q = %b", Q_tb);
        end

    end

    initial begin
        gen_vcd_file;
        $monitor("Clk=%b J=%b K=%b Q=%b tiempo=%0dns",clk_tb, J_tb, K_tb,  Q_tb, $time);

        // Inicializar los valores de entrada en el tiempo 0
        clk_tb = 0; J_tb = 0; K_tb = 0;
        Q_prev = 0;
        reset_async_tb = 0;
        #5
        reset_async_tb = 1;

        // Revisar archivo de onda vcd para verificar el funcionamiento del FF
        repeat(20) begin
            J_tb = $urandom_range(0,1);
            K_tb = $urandom_range(0,1); 
            #5;
        end 

        reset_async_tb = 0;
        #5
        reset_async_tb = 1;

        // Revisar archivo de onda vcd para verificar el funcionamiento del FF
        repeat(20) begin
            J_tb = $urandom_range(0,1);
            K_tb = $urandom_range(0,1); 
            #5;
        end 

        $finish;
    end

endmodule