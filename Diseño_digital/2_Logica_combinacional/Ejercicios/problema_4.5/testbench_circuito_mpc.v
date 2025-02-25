module testbench_circuito_mnc;
    // Entradas y salidas del test
    reg [2:0] xyz_tb;
    wire reg [2:0] ABC_tb;

    // Vectores para las tareas del test
    reg [2:0] values [0:7];

    // Instanciación del modulo
    circuito_mpc uut(
        .XYZ(xyz_tb),
        .ABC(ABC_tb)
    );

    // Tareas del test

    // Generar valores de la tabla de verdad
    task gen_values;
        for(int i=0; i<=7; i=i+1) begin
            values[i] = i;
        end
    endtask

    // Mostrar los valores del vector values
    task mostrar_values;
        $display("Tabla de verdad con los posibles valores en las entradas ");
        $display("x  y  z  |");
        for(int i=0; i<=7; i=i+1) begin
            $display("%b  %b  %b  |", values[i][2], values[i][1], values[i][0]);
        end
    endtask

    task mostrar_xyz_tb;
        $display("Valores xyz");
        $display("X  Y  Z | A  B  C");
        $display("%b  %b  %b  |  %b  %b  %b",xyz_tb[2], xyz_tb[1], xyz_tb[0], ABC_tb[2], ABC_tb[1], ABC_tb[0]);
    endtask

    task put_values;
        // Generar numeros random para vector de entrada
        reg [2:0] opcion_random;
        opcion_random = $urandom_range(0,7);
        xyz_tb = values[opcion_random];
        #10;
        mostrar_xyz_tb;
    endtask

    task verify_circuit;
        // vector de entrada xyz_tb comparar con salida ABC
        // $display("Verify circuit ");
        if (xyz_tb <= 3'b011) begin
            if (ABC_tb == (xyz_tb + 3'b001)) begin
                $display("Prueba exitosa");
            end else begin
                $display("ERROR en la prueba menor a 3 \n");
                end

        end else if (xyz_tb > 3'b011) begin
            if (ABC_tb == (xyz_tb - 3'b001)) begin
                $display("Prueba exitosa");
            end else begin
                mostrar_xyz_tb;
                $display("ERROR en la prueba mayor a 3 \n");
                end     
        end

    endtask

    // Funcion main
    initial begin
        gen_values;
        // mostrar_values;
        repeat(20) begin
            put_values;
            verify_circuit;
            $display("------");
        end
        $finish;
    end
endmodule 