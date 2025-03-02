`include "FFJK_with_FFD_and_gates.v"

module testbench_FFJK_with_FFD_and_gates;
    // Entradas y salidas del testbench
    wire Q;
    reg clk, J, K, reset_async, data;

    // Vectores para las tareas 
    reg memoria;
    
    // instanciar el modulo
    FFJK uut(
        .Q(Q),
        .clk(clk), 
        .J(J), 
        .K(K),
        .reset_async(reset_async)
        // .data(data)
        );

    // Tareas del test
    task gen_vcd_file;
        $dumpfile("testbench_FFJK_with_FFD_and_gates");
        $dumpvars(0, testbench_FFJK_with_FFD_and_gates);
    endtask
    
    task verify();
        case({J,K})
        2'b00: 
            if(Q == memoria) 
                $display("Correcto A"); 
            else
                $display("ERROR A");
        2'b01:
            if(Q == 1'b0) 
                $display("Correcto B"); 
            else
                $display("ERROR B");
        2'b10:
            if(Q == 1'b1) 
                $display("Correcto C"); 
            else
                $display("ERROR C");
        2'b11:
            if(Q == (~memoria)) 
                $display("Correcto D");
            else
                $display("ERROR D");
        default: $display("Default");
        endcase
    endtask
    
    always #5 clk = ~clk; 
    
    always #5 memoria <= Q;

    always @(posedge clk) begin
        #0.5;
        if(reset_async) verify();
        else $display("PUSH RESET BUTTOM");
    end

    initial begin
        $monitor("Clk=%b Reset=%b JK=%b%b Q=%b tiempo=%0dns ",clk, reset_async,J, K, Q, $time);
        
        // Generar archivo de onda VCD
        gen_vcd_file;

        // Inicializar los valores
        clk = 0;
        J=0; K=0; 
        data = 0;
        
        reset_async = 0;
        #5 reset_async = 1;

        // #5 J=1; K=1;
        // #5 J=1; K=0;
        // #5 J=1; K=0;
        // #5 J=1; K=1;

        //    reset_async = 0;
        // #5 reset_async = 1;
        // #5 J=1; K=0;
        // #5 J=1; K=1;
        // #5 J=0; K=0;
        // #5 J=0; K=0;

        repeat(10) begin
            K = $urandom_range(0,1);
            J = $urandom_range(0,1);
            //  data =$urandom_range(0,1);
            #5;
        end

           reset_async = 0;
        #5 reset_async = 1;

        repeat(10) begin
            K = $urandom_range(0,1);
            J = $urandom_range(0,1); 
            // data =$urandom_range(0,1); 
            #5;
        end

        $finish;
    end
endmodule