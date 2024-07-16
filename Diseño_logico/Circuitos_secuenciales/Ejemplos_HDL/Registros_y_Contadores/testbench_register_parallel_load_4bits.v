`include "register_parallel_load_4bits.v"

module testbench_register_parallel_load_4bits;
    // Entradas y salidas del testbench
    wire [3:0] An_tb;
    reg clk_tb, carga_tb, reset_async_tb;
    reg [3:0] In_tb;

    // Vectores para las tareas
    reg [3:0] memoria;
    // Instanciar el modulo 
    register_parallel_load_4bits uut(
        .An(An_tb),
        .clk(clk_tb), 
        .carga(carga_tb),
        .In(In_tb),
        .reset_async(reset_async_tb)
    );

    // Tareas del testb
    task gen_vcd_file();
        $dumpfile("testbench_register_parallel_load_4bits");
        $dumpvars(0,testbench_register_parallel_load_4bits);
    endtask

    task verify();
        case(carga_tb)
        1'b0:
            if(An_tb == memoria) 
                $display("Correcto AAA");
            else $display("Error AAA");
        1'b1:
            if(An_tb == In_tb) 
                $display("Correcto BBB");
            else $display("Error BBB");
        endcase
    endtask

    // Generar reloj
    always #5 clk_tb = ~clk_tb;
    always #5 memoria <= An_tb;

    // Verficar en cada flanco de subida
    always @(posedge clk_tb) begin
        #0.5;
        if(reset_async_tb) verify();
        else $display("PUSH RESET BUTTOM");
    end

    initial begin
        // Monitorear las variable
        $monitor("clk=%b carga=%b In=%b An=%b tiempo=%0dns", clk_tb, carga_tb, In_tb, An_tb, $time);

        // Generar archivos vcd
        gen_vcd_file();

        // Inicializar las variables
        // El circuito deja pasar informacion en carga_tb = 1
        clk_tb = 0; carga_tb = 0; In_tb = 0;
        reset_async_tb = 0;
        
        #10 reset_async_tb = 1;

        repeat(10) begin
            carga_tb = $urandom_range(0,15);
            In_tb = $urandom_range(0,15);
            #10;
        end

        reset_async_tb = 0;
        #5; carga_tb = 1; reset_async_tb = 1;

        repeat(10) begin
            carga_tb = $urandom_range(0,15);
            In_tb = $urandom_range(0,15);
            #10;
        end

        // #10
        // reset_async_tb = 1;
        // carga_tb = 1;
        // // In_tb = 4'h5;
        // In_tb =2'b11;
        // #10;
        
        // carga_tb = 1;
        // // In_tb = 4'hC;
        // In_tb =2'b01;
        // #10;

        // carga_tb = 1;
        // // In_tb = 4'h5;
        // In_tb =2'b10;
        // #10;

        // carga_tb = 1;
        // // In_tb = 4'hD;
        // In_tb =2'b10;
        // #10;

        // carga_tb = 1;
        // // In_tb = 4'hE;
        // In_tb =2'b11;
        // #10;

        // carga_tb = 1;
        // // In_tb = 4'hE;
        // In_tb =2'b00;
        // #10;

        // carga_tb = 1;
        // // In_tb = 4'hE;
        // In_tb =2'b01;
        // #10;

        // carga_tb = 1;
        // // In_tb = 4'hE;
        // In_tb =2'b10;
        // #10;

        $finish;
    end 
endmodule