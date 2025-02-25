module testbench_complementador_a_2;
    // Vectores de entrada y salida
    reg [3:0] ABCD_tb;
    reg [3:0] wxyz_tb;

    // Vectores para las tareas
    reg [3:0] values [0:15];

    // Instanciación del modulo
    complementador_a_2_mpc uut(
        .ABCD(ABCD_tb),
        .wxyz(wxyz_tb)
    );

    // Tareas para el testbench
    // gen_values - mostrar_values - put_values - mostrar_entrada - verify

    task gen_values;
        $display("Tabla con los posibles valores de entrada ");
        for(int i=0; i<=15; i++) begin
            values[i]=i;
        end
    endtask

    task mostrar_values;
        $display("ABCD");
        for(int i=0; i<=15; i++) begin
            $display("%4b", values[i]);
        end
    endtask

    task put_values;
        // Generar valores random
        reg [3:0] opcion_random;
        opcion_random=$urandom_range(0,15);

        // Poner valores
        ABCD_tb=values[opcion_random];
        // tiempo para cargar datos
        #10;
    endtask

    task mostrar_entrada_salida_tb;
        $display("Entrada= %4b | %4b =Salida",ABCD_tb, wxyz_tb);
    endtask
    
    task verify;
        case(ABCD_tb)
        4'b0001:
                if(wxyz_tb==4'b1111) begin
                    $display("Prueba correcta Salida %4b=0000", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=0000", wxyz_tb);
                end 
        4'b0010:    
                if(wxyz_tb==4'b1110) begin
                    $display("Prueba correcta Salida %4b=1111", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=1111", wxyz_tb);
                end 
        4'b0011:    
                if(wxyz_tb==4'b1101) begin
                    $display("Prueba correcta Salida %4b=1101", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=1101", wxyz_tb);
                end 
        4'b0100:    
                if(wxyz_tb==4'b1100) begin
                    $display("Prueba correcta Salida %4b=1100", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=1100", wxyz_tb);
                end 
        4'b0101:    
                if(wxyz_tb==4'b1011) begin
                    $display("Prueba correcta Salida %4b=1011", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=1011", wxyz_tb);
                end 
        4'b0110:    
                if(wxyz_tb==4'b1010) begin
                    $display("Prueba correcta Salida %4b=1010", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=1010", wxyz_tb);
                end 
        4'b0111:    
                if(wxyz_tb==4'b1001) begin
                    $display("Prueba correcta Salida %4b=1001", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=1001", wxyz_tb);
                end 
        4'b1000:    
                if(wxyz_tb==4'b1000) begin
                    $display("Prueba correcta Salida %4b=1000", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=1000", wxyz_tb);
                end 
        4'b1001:    
                if(wxyz_tb==4'b0111) begin
                    $display("Prueba correcta Salida %4b=0111", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=0111", wxyz_tb);
                end 
        4'b1010:    
                if(wxyz_tb==4'b0110) begin
                    $display("Prueba correcta Salida %4b=0110", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=0110", wxyz_tb);
                end 
        4'b1011:    
                if(wxyz_tb==4'b0101) begin
                    $display("Prueba correcta Salida %4b=0101", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=0101", wxyz_tb);
                end 
        4'b1100:    
                if(wxyz_tb==4'b0100) begin
                    $display("Prueba correcta Salida %4b=0100", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=0100", wxyz_tb);
                end 
        4'b1101:    
                if(wxyz_tb==4'b0011) begin
                    $display("Prueba correcta Salida %4b=0011", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=0011", wxyz_tb);
                end 
        4'b1110:    
                if(wxyz_tb==4'b0010) begin
                    $display("Prueba correcta Salida %4b=0010", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=0010", wxyz_tb);
                end 
        4'b1111:    
                if(wxyz_tb==4'b0001) begin
                    $display("Prueba correcta Salida %4b=0001", wxyz_tb);
                end else begin
                    $display("Error Salida %4b!=0001", wxyz_tb);
                end
        default: $display("DEFAULT en los valores %4b", ABCD_tb);
        endcase
    endtask

    initial begin
        gen_values;
        mostrar_values;
        repeat(30) begin
            put_values;
            mostrar_entrada_salida_tb;
            verify;
            $display("\n");
        end
    end
endmodule