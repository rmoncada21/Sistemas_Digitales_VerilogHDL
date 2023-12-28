module testbench_mux4x1_mfd;
    // Entradas del testbench
    reg [1:0] ES_tb;
    reg [3:0] A_tb, B_tb;
    wire [3:0] Y_tb;

    // Vectores para las tareas
    reg [3:0] values [15:0];

    // Instanciación del circuito a testear
    mux4x1_mfd uut(
        .ES(ES_tb),
        .A(A_tb),
        .B(B_tb),
        .Y(Y_tb)
    );

    // Tareas del testbench

    // Generar los valores de las entradas
    task gen_values;
        $display("Tabla de verdad del vector values ");
        $display("X3 X2 X1 X0");
        for (int i=0; i<=15; i=i+1) begin
            values[i] = i;
            $display("%b  %b  %b  %b", values[i][3], values[i][2], values[i][1], values[i][0]);
        end
    endtask

    // Verificar el funcionamiento del circuito modelado por flujo de datos
    task put_values_inputs;
        // Declarar variables para el task varify 
        reg [3:0] A_random;
        reg [3:0] B_random;

        // Generar numeros random 
        // numero random para la entrada de ES: Enable-Select
        ES_tb = $urandom_range(0,3);
        A_random = $urandom_range(0,15);
        B_random = $urandom_range(0,15);

        // Inicializar los vectores de entradas A y B
        A_tb = values[A_random];
        #1;
        B_tb = values[B_random];
        #1;

        // Mostrar los vectores de entrada
        $display("Vector A | Vector B | Enable-Select");
        $display("  %4b       %4b       %2b", A_tb, B_tb, ES_tb);
        $display("Vector Y");
        $display("  %4b ", Y_tb);
        
    endtask

    task verify_circuit;
        case (ES_tb)
            2'b11, 2'b10: begin
                if( Y_tb[3]==0 && Y_tb[2]==0 && Y_tb[1]==0 && Y_tb[0]==0 ) begin
                    $display("Prueba exitosa ");
                end
            end
            2'b00: begin
                if( Y_tb[3]==A_tb[3] && Y_tb[2]==A_tb[2] && Y_tb[1]==A_tb[1] && Y_tb[0]==A_tb[0] ) begin
                    $display("Prueba exitosa ");
                end
            end
            2'b01: begin
                if( Y_tb[3]==B_tb[3] && Y_tb[2]==B_tb[2] && Y_tb[1]==B_tb[1] && Y_tb[0]==B_tb[0] )
                    $display("Prueba exitosa ");
            end
            default: begin
                $display("ERROR prueba fallida");
            end
        endcase
    endtask

    initial begin
        gen_values;
        repeat(10) begin
            put_values_inputs;
            verify_circuit;
            $display("\n");
        end
    end
endmodule