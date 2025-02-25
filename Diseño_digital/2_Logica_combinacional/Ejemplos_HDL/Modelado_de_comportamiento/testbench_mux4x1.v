module tb_mux4x1;

    // Entradas y salidas del Testbench
    reg i0, i1, i2, i3;
    reg [1:0] select;
    wire y;

    // Instancia del multiplexor
    mux4x1 uut(
        .i0(i0),
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .select(select),
        .y(y)
    );

    // Inicialización de las señales
    initial begin
        // Configurar el monitor para observar las variables especificadas
        $monitor("Time=%0t i0=%b i1=%b i2=%b i3=%b select=%b y=%b", $time, i0, i1, i2, i3, select, y);

        // Prueba 1
        i0 = 1; i1 = 0; i2 = 1; i3 = 0; select = 2'b00;
        #10; // Esperar 10 unidades de tiempo

        // Prueba 2
        i0 = 1; i1 = 0; i2 = 1; i3 = 0; select = 2'b01;
        #10;

        // Prueba 3
        i0 = 0; i1 = 1; i2 = 1; i3 = 0; select = 2'b10;
        #10;

        // Prueba 4
        i0 = 0; i1 = 0; i2 = 0; i3 = 1; select = 2'b11;
        #10;

        // Puedes agregar más pruebas según sea necesario

        $stop; // Detener la simulación
    end

endmodule

