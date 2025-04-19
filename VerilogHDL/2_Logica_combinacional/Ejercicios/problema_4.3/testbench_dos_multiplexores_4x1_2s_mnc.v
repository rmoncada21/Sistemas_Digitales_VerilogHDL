`timescale 1ns/1ps
module testbench_dos_multiplexores_4x1_2s_mnc;
    // Entradas y salidas del testbench
    reg [3:0] A_tb;
    reg [3:0] B_tb;
    reg [1:0] ES_tb;
    wire Y0, Y1, Y2, Y3;

    // Vectores para las tareas
    reg [3:0] values [0:15];

    // Instanciacion del modulo
    dos_multiplexores_4x1_2s_mnc uut(
        .A0(A_tb[0]),
        .A1(A_tb[1]),
        .A2(A_tb[2]),
        .A3(A_tb[3]),
        .B0(B_tb[0]),
        .B1(B_tb[1]),
        .B2(B_tb[2]),
        .B3(B_tb[3]),
        .S(ES_tb[0]),
        .E(ES_tb[1]),
        .Y0(Y0), 
        .Y1(Y1), 
        .Y2(Y2), 
        .Y3(Y3)
    );

    // Tareas del testbench

    // Generar valores para los vectores de entrada
    task gen_values;
        $display("Tabla de verdad de los posibles valores de entrada");
        $display("AB0 AB1 AB2 AB3");
        for (int i=0; i<=15; i=i+1) begin
            values[i] = i;
            $display("  %b  %b   %b  %b", values[i][0], values[i][1], values[i][2], values[i][3]);
        end
    endtask

    task verify_circuit;
        reg [1:0] ES_random;
        reg [3:0] opcion_A;
        reg [3:0] opcion_B;

        // generar numeros random para escoger las emtradas
        ES_random = $urandom_range(0,3);
        // $display("numero random ES es: %2b ", ES_random);
        opcion_A = $urandom_range(0,15);
        // $display("numero random  A es: %0d ", opcion_A);
        opcion_B = $urandom_range(0,15);
        // $display("numero random  B es: %0d ", opcion_B);

        // dar las entradas al modulo
        // valores a las entradas Select y Enable
        ES_tb = ES_random;

        // valores para las entradas A y B
        A_tb = values[opcion_A];
        #10;
        B_tb = values[opcion_B];
        #10;

        $display("\Vector A");
        $display("A0  A1  A2  A3 | ES  Y0  Y1  Y2  Y3 ");
        $display("%b    %b   %b   %b | %2b  %b    %b   %b   %b ", A_tb[0], A_tb[1], A_tb[2], A_tb[3], ES_tb, Y0, Y1, Y2, Y3);
        $display("%b   %b", ES_tb[0], ES_tb[1]);
        $display("\Vector B");
        $display("B0  B1  B2  B3 | ES  Y0  Y1  Y2  Y3 ");
        $display("%b    %b   %b   %b | %2b  %b    %b   %b   %b ", B_tb[0], B_tb[1], B_tb[2], B_tb[3], ES_tb, Y0, Y1, Y2, Y3);

        $display("  --  ");

        // verficar el funcionamientp
        case (ES_tb)
            2'b11, 2'b10: begin
                if (Y0 == 0 && Y1 == 0 && Y2 == 0 && Y3 == 0 ) begin
                    $display("Prueba exitosa: Y's = ceros ");
                end
            end
            2'b00: begin
                if (Y0 == A_tb[0] && Y1 == A_tb[1] && Y2 == A_tb[2] && Y3 == A_tb[3]) begin
                    $display("Prueba exitosa: Y's = A_vector ");
                end
            end
            2'b01: begin
                if (Y0 == B_tb[0] && Y1 == B_tb[1] && Y2 == B_tb[2] && Y3 == B_tb[3] ) begin
                    $display("Prueba exitosa: Y's = B_vector ");
                end
            end
            default: begin
                $display("ERROR en la prueba");
            end
        endcase
    endtask

    initial begin
        gen_values;
        repeat(10) begin
            $display("-----");
            verify_circuit;
        end
        $finish;
    end 
endmodule