module testbench_gray_binary_mpc;
    // Entradas y salidas del testbench
    reg [3:0] GRAY_tb;
    wire reg [3:0] wxyz_tb;

    // Vectores del test
    reg [3:0] values [0:15];

    // Instanciación del circuito
    gray_binary_mpc uut(
        .GRAY(GRAY_tb),
        .wxyz(wxyz_tb)
    );

    // Tareas del sistema
    
    // gen values
    task gen_values;
        for (int i=0; i<=15; i++) begin
            values[i]=i;
        end 
    endtask

    // mostrar values
    task mostrar_values;
        $display("Tabla de verdad con los posibles valores de entrada");
        $display("GRAY");
        for (int i=0; i<=15; i++) begin
            $display("%4b",values[i]);
        end 
    endtask
    
    // put values
    task put_values;
        // generar random
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,15);

        // obtener el vector 
        GRAY_tb = values[opcion_random];
        #10;
        // $display("Salida %4b ", wxyz);
    endtask
    
    // mostrar entradas
    task mostrar_entradas_gray;
        $display("GRAY  Salida");
        $display("%4b   %4b",GRAY_tb, wxyz_tb);
    endtask

    // verificar
    task verify;
        case(GRAY_tb)
            4'b0000: 
                if (wxyz_tb == 4'b0000) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b0001: 
                if (wxyz_tb == 4'b0001) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b0011: 
                if (wxyz_tb == 4'b0010) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b0010: 
                if (wxyz_tb == 4'b0011) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b0110: 
                if (wxyz_tb == 4'b0100) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b0111: 
                if (wxyz_tb == 4'b0101) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b0101: 
                if (wxyz_tb == 4'b0110) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b0100: 
                if (wxyz_tb == 4'b0111) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b1100: 
                if (wxyz_tb == 4'b1000) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b1101: 
                if (wxyz_tb == 4'b1001) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b1111: 
                if (wxyz_tb == 4'b1010) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b1110: 
                if (wxyz_tb == 4'b1011) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b1010: 
                if (wxyz_tb == 4'b1100) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b1011: 
                if (wxyz_tb == 4'b1101) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b1001: 
                if (wxyz_tb == 4'b1110) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            4'b1000: 
                if (wxyz_tb == 4'b1111) begin
                    $display("Prueba exitosa %4b=%4b", GRAY_tb, wxyz_tb);
                    end else begin
                        $display("ERROR  %4b!= %4b", GRAY_tb, wxyz_tb);
                    end 
            default: 
                $display("ERROR Defautl ");
        endcase
    endtask

    initial begin
        gen_values;
        mostrar_values;
        repeat(30) begin
            put_values;
            mostrar_entradas_gray;
            verify;
            $display("  \n");
        end
        // GRAY_tb = 4'b1100;
        // #10
        // $display("Entrada %4b", GRAY_tb);
        // $display("Salida %4b ", wxyz_tb);
        // verify;
        // $finish;
    end
endmodule