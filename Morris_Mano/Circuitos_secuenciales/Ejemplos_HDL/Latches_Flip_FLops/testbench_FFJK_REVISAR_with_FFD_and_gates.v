`include "FFJK_with_FFD_and_gates.v"

module testbench_FFJK_with_FFD_and_gates;
    // Entradas y salidas del testbench
    wire Q;
    reg clk, J, K, reset_async;

    // Vectores para las tareas 
    reg Q_prev;
    reg [1:0] JK;
    
    // instanciar el modulo
    FFJK uut(
        .Q(Q),
        .clk(clk), 
        .J(J), 
        .K(K), 
        .reset_async(reset_async)
        );

    // Tareas del test
    task gen_vcd_file;
        $dumpfile("testbench_FFJK_with_FFD_and_gates");
        $dumpvars(1, testbench_FFJK_with_FFD_and_gates);
    endtask
    
    task verify();
        Q_prev <= Q;
        
        case(JK)
        00: 
            if(Q==Q_prev) begin
                $display("Correcto");
            end else begin
                $display("ERROR a");
            end 
        01: $display("ERROR B");
        10: $display("ERROR C");
        11: $display("D");
            // if(Q==(~Q)) begin
            // end
        default: $display("OTRO");
        endcase
    endtask
    
    always #5 clk = ~clk; 
    always #5Q_prev <= Q;

    always @(posedge clk or reset_async) begin
        #0.5;
        verify();
    end

    initial begin
        $monitor("Clk=%b Reset=%b JK=%b%b Q=%b tiempo=%0dns ",clk, reset_async,J, K, Q, $time);
        
        // Generar archivo de onda VCD
        gen_vcd_file;

        // Inicializar los valores
        clk = 0;
        J=0; K=0; 
        
        reset_async = 0;
        #5 reset_async = 1;
        #5 J=1; K=1;
        #5 J=1; K=0;
        #5 J=1; K=0;
        #5 J=1; K=1;

        // repeat(5) begin
        //     J = $urandom_range(0,1);
        //     K = $urandom_range(0,1); 
        //     // JK = {J,K};
        //     // $display("JK=%b%b", J, K);
        //     #5;
        // end

           reset_async = 0;
        #5 reset_async = 1;
        #5 J=1; K=0;
        #5 J=1; K=1;
        #5 J=0; K=0;
        #5 J=0; K=0;
        // repeat(5) begin
        //     J = $urandom_range(0,1);
        //     K = $urandom_range(0,1); 
        //     // JK = {J,K};
        //     // $display("JK=%b%b", J, K);
        //     #5;
        // end

        $finish;
    end
endmodule