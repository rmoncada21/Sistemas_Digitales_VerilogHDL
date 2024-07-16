module testbench_sumador_BCD_4bits;
    // Vectores de entrada y salida
    wire Acarreo_BCD_tb;
    wire reg [3:0] Z_salida_tb;
    reg [3:0] A_tb, B_tb;
    reg Ac_in_tb;

    // Vectores para las tareas
    reg [3:0] values [0:15];
    
    // Instanciar el modulo
    sumador_BCD_4bits uut(
        .Acarreo_BCD(Acarreo_BCD_tb),
        .Z_salida(Z_salida_tb),
        .A(A_tb),
        .B(B_tb),
        .Ac_in(Ac_in_tb)
    );

    // Tareas del testbench
    // gen_values - mostrar_values - put_values - mostrar_entrada_salida - verify

    task gen_values;
        for(int i=0; i<=15; i++) begin
            values[i]=i;
        end
    endtask

    task mostrar_values;
        $display(" Tabla con los posibles valores de entradas \n ABCD");
        for(int i=0; i<=15; i++) begin
            $display(" %b", values[i]);
        end
    endtask

    task put_values;
        // Generar valores randdom 
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,9);
        A_tb = opcion_random;
        opcion_random = $urandom_range(0,9);
        B_tb = opcion_random;
        // Acarreo de entrada
        Ac_in_tb = 1'b0;
        // Tiempo para cargar los datos
        #10;

    endtask

    task verify;
        reg opcion_case;
        reg [4:0] suma_BCD;

        suma_BCD = A_tb+B_tb;

        // 0: menor a 10 | 1: mayor o igual 10
        if(suma_BCD<5'b01010) begin
            opcion_case = 1'b0;
        end else begin
            opcion_case = 1'b1;
        end

        case(opcion_case)
        1'b0: 
            if({Acarreo_BCD_tb, Z_salida_tb} == suma_BCD) begin
                $display("Prueba correcta A=%b + B=%b =%1b %4b", A_tb, B_tb, suma_BCD[4], suma_BCD[3:0]);
            end else begin
                $display("ERROR A=%b + B=%b !=%1b %4b", A_tb, B_tb, suma_BCD[4], suma_BCD[3:0]);
            end

        1'b1:
            if({Acarreo_BCD_tb, Z_salida_tb} == (suma_BCD+5'b00110)) begin
                $display("Prueba correcta A=%b + B=%b =%b %b", A_tb, B_tb, (suma_BCD+5'b00110)>2, (suma_BCD[3:0]+4'b0110));
            end else begin
                $display("ERROR A=%b + B=%b !=%b", A_tb, B_tb, (suma_BCD+5'b00110));
            end

        default: $display("Dentro de deffault");

        endcase
        
    endtask

    initial begin
        gen_values;
        mostrar_values;
        repeat(10) begin
            put_values;
            verify;
        end
    end
endmodule