module testbench_display_7seg;
    reg [3:0] iBCD_tb;
    reg [6:0] abcdefg_tb;

    // Vecores para las tareas
    reg [3:0] values [0:15];
    // Instanciar
    display_7seg uut(
        .iBCD(iBCD_tb),
        .abcdefg(abcdefg_tb)
    );

    // Tareas del sistema
    // gen_values - mostrar_values - put_values - mostrar_entrada

    task gen_values;
        for(int i=0; i<=15; i++) begin
            values[i]=i;
        end
    endtask

    task mostrar_values;
        $display("Tabla de verdad con los posibles valores de entrada ");
        $display("iBCD");
        for (int i=0; i<=15; i++) begin
            $display("%4b ", values[i]);
        end 
        $display("--------");
    endtask

    task put_values;
        // generar random
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,15);

        // poner valores en la entrada
        iBCD_tb = values[opcion_random];
        // tiempo para cargar datos
        #20;
    endtask

    task mostrar_entrada_salida_tb;
        $display("Entrada= %4b | %7b =Salida", iBCD_tb, abcdefg_tb);
    endtask

    task verify;
        case(iBCD_tb)
            4'b0000:
                if(abcdefg_tb == 7'b1111110) begin
                    $display("Prueba exitosa %7b = 1111110 ", abcdefg_tb);
                end else begin
                    $display("ERROR %7b != 1111110 ", abcdefg_tb);
                end 
            4'b0001:
                if(abcdefg_tb == 7'b0110000) begin
                    $display("Prueba exitosa %7b = 0110000 ", abcdefg_tb);
                end else begin
                    $display("ERROR %7b != 0110000 ", abcdefg_tb);
                end 
            4'b0010:
                if(abcdefg_tb == 7'b1101101) begin
                    $display("Prueba exitosa %7b = 1101101 ", abcdefg_tb);
                end else begin
                    $display("ERROR %7b != 1101101 ", abcdefg_tb);
                end 
            4'b0011:
                if(abcdefg_tb == 7'b1111001) begin
                    $display("Prueba exitosa %7b = 1111001 ", abcdefg_tb);
                end else begin
                    $display("ERROR %7b != 1111001 ", abcdefg_tb);
                end 
            4'b0100:
                if(abcdefg_tb == 7'b0111011) begin
                    $display("Prueba exitosa %7b = 0110011 ", abcdefg_tb);
                end else begin
                    $display("ERROR %7b != 0110011 ", abcdefg_tb);
                end 
            4'b0101:
                if(abcdefg_tb == 7'b1011011) begin
                    $display("Prueba exitosa %7b = 1001011 ", abcdefg_tb);
                end else begin
                    $display("ERROR %7b != 1001011 ", abcdefg_tb);
                end 
            4'b0110:
                if(abcdefg_tb == 7'b1011111) begin
                    $display("Prueba exitosa %7b = 1001111 ", abcdefg_tb);
                end else begin
                    $display("ERROR %7b != 1001111 ", abcdefg_tb);
                end 
            4'b0111:
                if(abcdefg_tb == 7'b1110000) begin
                    $display("Prueba exitosa %7b = 1110000 ", abcdefg_tb);
                end else begin
                    $display("ERROR %7b != 1110000 ", abcdefg_tb);
                end 
            // 4'b1000:
            //     if(abcdefg_tb == 7'b1111111) begin
            //         $display("Prueba exitosa %7b = 1111111 ", abcdefg_tb);
            //     end else begin
            //         $display("ERROR %7b != 1111111 ", abcdefg_tb);
            //     end 
            // 4'b1001:
            //     if(abcdefg_tb == 7'b1111011) begin
            //         $display("Prueba exitosa %7b = 1111011 ", abcdefg_tb);
            //     end else begin
            //         $display("ERROR %7b != 1111011 ", abcdefg_tb);
            //     end
            default: $display("Valor default");
        endcase
        $display("\n");
    endtask

    initial begin
    $display("Testbench done ");
    gen_values;
    mostrar_values;

    repeat(20) begin
        put_values;
        mostrar_entrada_salida_tb;
        verify;
    end

    end
endmodule 