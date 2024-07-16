// Archivo: testbench_sumador4bits.v
`timescale 1ns/1ps  // Definición de la escala de tiempo

module testbench_sumador;
    // Declaración de señales
    reg [3:0] a, b;
    wire [4:0] sum;

    // Instanciación del sumador
    sumador uut(
        .a(a),
        .b(b),
        .sum(sum)
    );

    // Inicialización de señales
    initial begin
        $dumpfile("testbench_sumador.vcd");
        $dumpvars(0, testbench_sumador);
        
        
        // Prueba 1
        a = 4'b0010;
        b = 4'b0011;
        #10;  // Espera 10 unidades de tiempo
        if (sum !== 5'b00101) begin
            $display("Error en la Prueba 1");
            $fatal;
        end else begin
            $display("Prueba 1 pasada correctamente");
        end

        // Prueba 2
        a = 4'b1100;
        b = 4'b1010;
        #10;
        if (sum !== 5'b10110) begin
            $display("Error en la Prueba 2");
            $fatal;
        end else begin
            $display("Prueba 2 pasada correctamente");
        end

        // Añade más pruebas según sea necesario

        $finish;  // Termina la simulación
    end

endmodule
