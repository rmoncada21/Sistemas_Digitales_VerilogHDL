`include "extern_FFD.v"

module testbench_extern_FFD;
    // Entradas y salidas del testbench
    wire Q;
    reg clk, reset_async;
    reg a, b;
    reg data;

    // Vectores para las tareas 
    reg Q_prev;
    reg mult;
    reg x, y, z;
    reg aa, bb, cc;
    // reg [1:0] JK;
    
    // instanciar el modulo
    extern_FFD uut(
        .Q(Q),
        .clk(clk), 
        .reset_async(reset_async),
        .a(a),
        .b(b),
        .data(data)
        );

    // Tareas del test
    task gen_vcd_file;
        $dumpfile("testbench_extern_FFD");
        $dumpvars(0, testbench_extern_FFD);
    endtask
    
    task verify();
    endtask
    
    always #5 clk = ~clk; 
    always #5 Q_prev <= Q;

    always @(posedge clk or reset_async) begin
        #0.5;
        // verify();
    end

    initial begin
        $monitor("Clk=%b Reset=%b a=%b b=%b mult=%b Q=%b tiempo=%0dns ",clk, reset_async,a, b, mult, Q, $time);
        
        // Generar archivo de onda VCD
        gen_vcd_file;

        // Inicializar los valores
        clk = 0;
        data = 0;
        a=0; b=0;
        mult = 0;
        z=0;
        
        reset_async = 0;
        #5 reset_async = 1;


        repeat(10) begin
            // data = $urandom_range(0,1);
            a = $urandom_range(0,1);
            b = $urandom_range(0,1);
            assign mult = (!a*b)+(a+!b);
            assign z = (~a&b)|(a|~b);
            #5;
        end

           reset_async = 0;
        #5 reset_async = 1;

        repeat(10) begin 
            // data =$urandom_range(0,1); 
            a = $urandom_range(0,1);
            b = $urandom_range(0,1);
            assign mult = (a*b)+(a+b);
            assign z = (a&b)|(a|b);
            #5;
        end
        
        x= 1; y = 1; z=0; 
        assign mult = (x&~z)|(~y&z);
        $display("a multi=%b", mult);

        assign mult = (x*~z)+(~y*z);
        $display("b multi=%b", mult);

        $finish;
    end
endmodule