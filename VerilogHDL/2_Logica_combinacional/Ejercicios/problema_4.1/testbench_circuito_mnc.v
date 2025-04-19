module testbench_circuito;

    // Definir parámetros
    parameter N = 16; // Número de casos de prueba

    // Declaración de señales
    reg [3:0] in;
    wire F1, F2;

    // Declaracion de un vector anidado para los valores de salida F's
    reg [1:0] valores_F1F2 [15:0];

    // Declaración de funciones
    function void run_test(int test_num);
        // Asignar los valores de entrada
        in = test_num;

        // Evaluar el circuito
        // #10; // Esperar un tiempo para que los cambios se propaguen
        if ((valores_F1F2[test_num][1] == F1) && (valores_F1F2[test_num][0] == F2)) begin
            $display("Caso de prueba: %d correcto", test_num);
        end else begin
            $display("Error en la Prueba: %d F1 = %b F2 = %b", test_num, F1, F2);
            $fatal;
        end
    endfunction

    // Inicializar los valores de valores_F1F2
    initial begin
        valores_F1F2[0]  = 2'b00;
        valores_F1F2[1]  = 2'b11;
        valores_F1F2[2]  = 2'b10;
        valores_F1F2[3]  = 2'b11;
        valores_F1F2[4]  = 2'b11;
        valores_F1F2[5]  = 2'b01;
        valores_F1F2[6]  = 2'b11;
        valores_F1F2[7]  = 2'b01;
        valores_F1F2[8]  = 2'b10;
        valores_F1F2[9]  = 2'b11;
        valores_F1F2[10] = 2'b10;
        valores_F1F2[11] = 2'b11;
        valores_F1F2[12] = 2'b10;
        valores_F1F2[13] = 2'b11;
        valores_F1F2[14] = 2'b10;
        valores_F1F2[15] = 2'b11;
    end

    // Bucle principal de prueba
    initial begin
        $display("\nTESTBENCH de circuito_mnc.v");
        $display("ABCD  F1  F2");
        for (int test_num = 0; test_num < N; test_num = test_num + 1) begin
            // Asignar los valores de entrada
            in = test_num;

            // Evaluar el circuito
            #10; // Esperar un tiempo para que los cambios se propaguen
            if ((valores_F1F2[test_num][1] == F1) && (valores_F1F2[test_num][0] == F2)) begin
                // $display("Caso de prueba: %d correcto", test_num);
            end else begin
                $display("Error en la Prueba: %d F1 = %b F2 = %b", test_num, F1, F2);
                // $fatal;
            end
        end

        // Finalizar la simulación
        $finish;
    end

    // Monitor para mostrar las señales en cada paso de simulación
    initial begin
        $monitor("%b  %b    %b", in, F1, F2);
    end

    // Instanciar el diseño bajo prueba
    circuito_compuertas uut(
        .A(in[3]),
        .B(in[2]),
        .C(in[1]),
        .D(in[0]),
        .F1(F1),
        .F2(F2)
    );

endmodule




// module testbench_circuito;
//     // Reemplazar las típicas entradas por un vector 
//     reg [3:0] in;
//     // Salidas tipo wire
//     wire F1, F2;

//     // Declaracion de un vector anidado para los valores de salida F's
//     reg [1:0] valores_F1F2 [15:0];

//     // Variable contador
//     // Hacer el registro un bit mayor si no, el ciclo no termina
//     reg [4:0] contador;

//     circuito_compuertas uut(
//         .A(in[3]),
//         .B(in[2]),
//         .C(in[1]),
//         .D(in[0]),
//         .F1(F1),
//         .F2(F2)
//     );

//     // Inicializar los valores de valores_F1F2
//     initial begin
//         valores_F1F2[0]  = 2'b00;
//         valores_F1F2[1]  = 2'b11;
//         valores_F1F2[2]  = 2'b10;
//         valores_F1F2[3]  = 2'b11;
//         valores_F1F2[4]  = 2'b10;
//         valores_F1F2[5]  = 2'b01;
//         valores_F1F2[6]  = 2'b11;
//         valores_F1F2[7]  = 2'b01;
//         valores_F1F2[8]  = 2'b10;
//         valores_F1F2[9]  = 2'b11;
//         valores_F1F2[10] = 2'b10;
//         valores_F1F2[11] = 2'b11;
//         valores_F1F2[12] = 2'b10;
//         valores_F1F2[13] = 2'b11;
//         valores_F1F2[14] = 2'b10;
//         valores_F1F2[15] = 2'b11;
//     end

//     initial begin
//         contador = 0;
//         while (contador <=15) begin
//             // Asignar los valores de entrada
//             in = contador;

//             // Evaluar el circuito
//             #10; // Esperar un tiempo para que los cambios se propaguen
//             if ((valores_F1F2[contador][1] == F1) && (valores_F1F2[contador][0] == F2)) begin
//                 $display("Caso de prueba: %d correcto", contador);
//             end else begin
//                 $display("Error en la Prueba: %d   F1 = %b F2 = %b", contador, F1, F2);
//                 // $fatal;
//             end

//             contador = contador + 1;
//         end

//         // Finalizar la simulación
//         $finish;
//     end

//     initial begin
//         $display("ABCD  F1  F2");
//         $monitor("%b  %b    %b", in, F1, F2);
//     end

// endmodule