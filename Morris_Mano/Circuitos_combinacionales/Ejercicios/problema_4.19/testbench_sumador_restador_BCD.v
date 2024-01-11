module testbench_sumador_restador_BCD;
    // Vectores de entrada y salida del test
    wire reg[3:0] Z_SR_tb;
    wire Acarreo_out_SR_tb;

    reg Acarreo_in_SR_tb;
    reg [3:0] A_SR_tb, B_SR_tb;
    reg mux_suma_resta_tb;

    // Vectores para las tareas
    reg [3:0] values [0:15];

    // Instanciar modulo
    sumador_restador_BCD uut(
        .Z_SR(Z_SR_tb),
        .Acarreo_out_SR(Acarreo_out_SR_tb),
        .Acarreo_in_SR(Acarreo_in_SR_tb),
        .A_SR(A_SR_tb),
        .B_SR(B_SR_tb),
        .mux_suma_resta(mux_suma_resta_tb)
    );

    // Tareas para el testbench
    //gen_values - mostrar_values - put_values - mostrar_entrada_salida - verify

    task gen_values;
        for(int i=0; i<=15; i++) begin
            values[i]=i;
        end
    endtask

    task mostrar_values;
        $display("Tabla con los posibles valores de entrada \n ABCD");
        for(int i=0; i<=15; i++) begin
            $display(" %b",  values[i]);
        end
    endtask

    task put_values;
        // Generar numero random
        reg [3:0] opcion_random;
        opcion_random = $urandom_range(0,9);

        // Poner los valores en las entradas
        A_SR_tb = opcion_random;
        opcion_random = $urandom_range(0,9);
        B_SR_tb = opcion_random;
        
        // Acarreo de entrada
        Acarreo_in_SR_tb = 1'b0;
        // Random para mux
        mux_suma_resta_tb = $urandom_range(0,1);
        // Tiempo para cargar los datos
        #10;
        
    endtask

    task verify_add;
        reg opcion_case;
        reg [4:0] suma_BCD;

        suma_BCD = A_SR_tb+B_SR_tb;

        // 0: menor a 10 | 1: mayor o igual 10
        if(suma_BCD<5'b01010) begin
            opcion_case = 1'b0;
        end else begin
            opcion_case = 1'b1;
        end

        case(opcion_case)
        1'b0: 
            if({Acarreo_out_SR_tb, Z_SR_tb} == suma_BCD) begin
                $display("Prueba correcta A=%b + B=%b =%1b %4b", A_SR_tb, B_SR_tb, suma_BCD[4], suma_BCD[3:0]);
            end else begin
                $display("ERROR A=%b + B=%b !=%1b %4b", A_SR_tb, B_SR_tb, suma_BCD[4], suma_BCD[3:0]);
            end

        1'b1:
            if({Acarreo_out_SR_tb, Z_SR_tb} == (suma_BCD+5'b00110)) begin
                $display("Prueba correcta A=%b + B=%b =%b %b", A_SR_tb, B_SR_tb, (suma_BCD+5'b00110)>2, (suma_BCD[3:0]+4'b0110));
            end else begin
                $display("ERROR A=%b + B=%b !=%b", A_SR_tb, B_SR_tb, (suma_BCD+5'b00110));
            end

        default: $display("Dentro de deffault");

        endcase
        
    endtask

    task verify_substract;
        reg opcion_case;
        reg [4:0] suma_BCD;
        reg [3:0] complemento_task;

        complemento_task = 4'b1001-B_SR_tb;
        suma_BCD = A_SR_tb+complemento_task+1'b1;

        // 0: menor a 10 | 1: mayor o igual 10
        if(suma_BCD<5'b01010) begin
            opcion_case = 1'b0;
        end else begin
            opcion_case = 1'b1;
        end

        case(opcion_case)
        1'b0: 
            if({Acarreo_out_SR_tb, Z_SR_tb} == suma_BCD) begin
                $display("RESTA Prueba correcta A=%b + B=%b =%1b %4b", A_SR_tb, B_SR_tb, suma_BCD[4], suma_BCD[3:0]);
            end else begin
                $display("RESTA ERROR A=%b + B=%b !=%1b %4b", A_SR_tb, B_SR_tb, suma_BCD[4], suma_BCD[3:0]);
            end

        1'b1:
            if({Acarreo_out_SR_tb, Z_SR_tb} == (suma_BCD+5'b00110)) begin
                $display("RESTA Prueba correcta A=%b + B=%b =%b %b", A_SR_tb, B_SR_tb, (suma_BCD+5'b00110)>2, (suma_BCD[3:0]+4'b0110));
            end else begin
                $display("RESTA ERROR A=%b + B=%b !=%b", A_SR_tb, B_SR_tb, (suma_BCD+5'b00110));
            end

        default: $display("Dentro de deffault");

        endcase
        
    endtask

    initial begin
        gen_values;
        mostrar_values;
        repeat(10) begin
            put_values;

            case(mux_suma_resta_tb)
            1'b0: verify_add;
            1'b1: verify_substract;
            endcase
            
            $display("");
        end
    end
endmodule