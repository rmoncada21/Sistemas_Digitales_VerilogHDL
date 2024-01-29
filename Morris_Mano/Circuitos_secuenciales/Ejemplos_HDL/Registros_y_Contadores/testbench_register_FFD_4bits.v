`include "register_FFD_4bits.v"

module testbench_register_FFD_4bits;
    // Entradas y salidas del testb
    wire [3:0] An_tb;
    reg clk_tb, clear_tb;
    reg [3:0] In_tb;

    // Vectores para las tareas 
    reg [3:0] estado_ant;
    // Instanciar el modulo
    register_FFD_4bits uut(
        .An(An_tb),
        .clk(clk_tb),
        .clear(clear_tb),
        .In(In_tb)
    );

    // Tareas del sistema 

    task gen_vcd_file();
        $dumpfile("testbench_register_FFD_4bits");
        $dumpvars(0,testbench_register_FFD_4bits);        
    endtask

    // verificar el funcionamiento
    task verify(reg [3:0] estado_ant);
        if (An_tb == estado_ant) 
            $display("Correcto In_tb=%b An_tb=%b Estado_ant=%b", In_tb, An_tb, estado_ant);
        else
            $display("ERROR In_tb=%b An_tb=%b Estado_ant=%b ", In_tb, An_tb, estado_ant);
    endtask

    // Generar la señal de reloj
    always #5 clk_tb = ~ clk_tb;
    always #5 estado_ant <= In_tb;

    // Verificar en los flanco de subida
    always @ (posedge clk_tb) begin
        #0.5;
        if(~clear_tb) $display("PUSH CLEAR BOTTOM");
        else verify(estado_ant);
    end 

    initial begin
        gen_vcd_file();
        $monitor("clk=%b Clear=%b In=%b An=%b Estado_ant=%b tiempo=%0dns", clk_tb, clear_tb, In_tb, An_tb, estado_ant, $time);
        
        // inicalizar los valores
        clk_tb = 0; In_tb = 0; estado_ant = 0;

        clear_tb = 0;
        #5; clear_tb = 1;

        // In_tb = 0101;

        repeat(10) begin
            In_tb = $urandom_range(0,15);
            // clear_tb = $urandom_range(0,1);
            #5;
        end
        
        clear_tb = 0;
        #5; clear_tb = 1;

        // In_tb = 0101;

        repeat(10) begin
            In_tb = $urandom_range(0,15);
            // clear_tb = $urandom_range(0,1);
            #5;
        end
        
        $finish;
    end
endmodule