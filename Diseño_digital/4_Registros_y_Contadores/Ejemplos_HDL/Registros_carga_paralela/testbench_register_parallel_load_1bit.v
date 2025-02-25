`include "register_parallel_load_1bit.v"

module testbench_register_parallel_load_1bit;
    // Entradas y salidas del test
    wire Q_tb;
    // reg clk_tb, carga_tb, In_tb, reset_async_tb;
    reg clk_tb, carga_tb, In_tb, reset_async_tb;

    // Vectores para las tareas
    reg memoria;

    // Instanciar el modulo
    register_parallel_load_1bit uut(
        .Q(Q_tb),
        .clk(clk_tb), 
        .carga(carga_tb), 
        .In(In_tb),
        .reset_async(reset_async_tb)
    );

    // Tareas para el test
    task gen_vcd_file();
        $dumpfile("testbench_register_parallel_load_1bit");
        $dumpvars(0, testbench_register_parallel_load_1bit);
    endtask

    task verify();
        
        case(carga_tb)
        1'b0: 
            if(Q_tb == memoria) 
                $display("Correcto AAA carga=%b In=%B D=%b tiempo=%0dns", carga_tb, In_tb, Q_tb, $time );
            else 
                $display("ERROR AAA carga=%b In=%B D=%b tiempo=%0dns", carga_tb, In_tb, Q_tb, $time );
        1'b1: 
            if(Q_tb == In_tb) 
                $display("Correcto BBB carga=%b In=%B D=%b tiempo=%0dns", carga_tb, In_tb, Q_tb, $time );
            else 
                $display("ERROR BBB carga=%b In=%B D=%b tiempo=%0dns", carga_tb, In_tb, Q_tb, $time );
        1'bx: $display("Default Q = x");
        endcase

    endtask

    // Generar el reloj
    always #5 clk_tb = ~clk_tb;
    always #5 memoria <= Q_tb;

    // Verificar en el flanco de subida
    always @ (posedge clk_tb) begin
        #0.5;
        if(reset_async_tb) verify();
        else $display("FFF");
    end

    initial begin
        $monitor("clk=%b carga=%b In=%B D=%b tiempo=%0dns",clk_tb, carga_tb, In_tb, Q_tb, $time );
        gen_vcd_file;

        // Inicializar los valores de entrada
        clk_tb = 0; carga_tb = 0; In_tb = 0; reset_async_tb = 0;
        #5; reset_async_tb = 1;

        repeat(20) begin
            In_tb = $urandom_range(0,1);
            carga_tb = $urandom_range(0,1);
            #10;
            // Cargar datos en cada ciclo de reloj
        end

        $finish;
    end
endmodule