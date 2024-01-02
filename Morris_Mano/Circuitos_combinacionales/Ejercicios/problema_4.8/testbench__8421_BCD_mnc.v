module testbench__con_8421_BCD;
    // Entradas y salidas del testbench
    reg ocho_tb, cuatro_tb, dos_tb, uno_tb;
    wire B_tb, C_tb, D_tb, d_tb;

    // Vectores para las tareas 
    reg [3:0] values [0:15];
    reg [3:0] verify_vector;
    reg [3:0] salida_vector;

    // Instanciación del circuito
    con_8421_BCD uut(
        .ocho(ocho_tb),
        .cuatro(cuatro_tb),
        .dos(dos_tb),
        .uno(uno_tb),
        .B(B_tb),
        .C(C_tb),
        .D(D_tb),
        .d(d_tb)
    );

    // Tareas del sistema

    // gen_values - mostrar values - put values - verify
    task gen_values;
        for (int i=0; i<=15; i++) begin
            values[i]=i;
        end
    endtask

    task mostrar_values;
        $display("Tabla de verdad con los posibles valores ");
        $display("8421");
        for (int i=0; i<=15; i++) begin
            $display("%4b ", values[i]);
        end
    endtask

    task put_values;
        // Generar random
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,15);
        // $display("Values: %4b, opcion: %d", values[opcion_random], opcion_random);
        {ocho_tb, cuatro_tb, dos_tb, uno_tb} = values[opcion_random];
        // Tiempo para cagar los datos en las entradas
        #20;
    endtask

    task mostrar_8421;
        $display("Valor Entrada: %4b ", {ocho_tb, cuatro_tb, dos_tb, uno_tb});
    endtask

    task verify;
        // Entrada
        verify_vector = {ocho_tb, cuatro_tb, dos_tb, uno_tb};
        salida_vector = {B_tb, C_tb, D_tb, d_tb};
        $display("Salida vector :%4b", salida_vector);
        case(verify_vector)
            4'b0000:
                if (salida_vector==4'b0000) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b0111:
                if (salida_vector==4'b0001) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b0110:
                if (salida_vector==4'b0010) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b0101:
                if (salida_vector==4'b0011) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b0100:
                if (salida_vector==4'b0100) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b1011:
                if (salida_vector==4'b0101) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b1010:
                if (salida_vector==4'b0110) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b1001:
                if (salida_vector==4'b0111) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b1000:
                if (salida_vector==4'b1000) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            4'b1111:
                if (salida_vector==4'b1001) begin
                    $display("Prueba exitosa entrada:%4b=%4b:salida", verify_vector, salida_vector);
                end else begin
                    $display("ERROR entrada:%4b!=%4b:salida", verify_vector, salida_vector);
                end
            default: $display("Default ");
        endcase
    endtask

    initial begin
        gen_values;
        mostrar_values;
        repeat(25) begin
            put_values;
            // $display("B_tb=%b, C_tb=%b", B_tb, C_tb);
            // $display("%4b", {B_tb, C_tb, D_tb, d_tb});
            mostrar_8421;
            verify;
            $display("\n");
        end
        $finish;
    end 
endmodule