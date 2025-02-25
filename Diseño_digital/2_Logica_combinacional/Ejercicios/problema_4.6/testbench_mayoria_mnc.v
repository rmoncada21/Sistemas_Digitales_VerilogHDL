module testbench_mayoria_mnc;
    // salidas y entradas del testbench
    reg [2:0] ABC_tb;
    wire F_tb;


    // Vectores para el testbench
    reg [2:0] values [0:7];
    reg [1:0] unos;
    reg [1:0] ceros;

    // Instanciar circuito
    mayoria_mnc uut (
        .ABC(ABC_tb),
        .F(F_tb)
    );

    // Tareas del testbench
    // gen_values---mostrar_values---put_values---verify_circuit
    
    task gen_values;
        for (int i=0; i<=7; i++) begin
            values[i] = i;
        end
    endtask

    task mostrar_values;
        unos = 0;
        ceros = 0;
        $display("Tabla de verdad con los posibles valores en las entradas y su salida respectiva ");
        $display("A  B  C  | F");
        for(int i=0; i<=7; i=i+1) begin

            for (int j=0; j<=2; j++) begin
                if (values[i][j]==1'b1) begin
                    unos=unos+1;
                    // $display("unos %h ", unos);
                end else begin
                    ceros=ceros+1;
                    // $display("ceros %h ", ceros);
                end
            end

            if (ceros>unos) begin
                $display("%b  %b  %b  | 0", values[i][2], values[i][1], values[i][0]);
            end else begin
                $display("%b  %b  %b  | 1", values[i][2], values[i][1], values[i][0]);
            end

            unos = 0;
            ceros = 0;
    
        end
    endtask

    task mostrar_ABC_tb;
        $display("Valores ABC");
        $display("A  B  C | F");
        $display("%b  %b  %b  | %b",ABC_tb[2], ABC_tb[1], ABC_tb[0], F_tb);
    endtask


    task put_values;
        // generar random 
        reg [2:0] opcion_random;
        opcion_random = $urandom_range(0,7);

        // Obtener el vector de entrada
        ABC_tb = values[opcion_random];
        #10;
        // mostrar_ABC_tb;
    endtask

    task verify_circuit;
        // contadores de unos y ceros
        reg [1:0] unos;
        reg [1:0] ceros;

        unos = 0;
        ceros = 0;

        // contar la cantidad de unos y ceros
        for (int k=0; k<=2; k++)
            if (ABC_tb[k]==1'b1)
                unos++;
            else 
                ceros++;

        $display("unos= %h", unos);
        $display("ceros= %h", ceros);
        
        // comparar
        if(unos>ceros)
            if(F_tb==1)
                $display("Prueba exitosa F_tb==1");
            else 
                $display("ERROR F_tb=!1");
        else 
            if(F_tb==0)
                $display("Prueba exitosa F_tb==0");
            else 
                $display("ERROR F_tb=!0");
        
        unos = 0;
        ceros = 0;
    endtask


    initial begin
        gen_values;
        mostrar_values;
        repeat(30) begin
            put_values;
            mostrar_ABC_tb;
            verify_circuit;
            $display("\n");
        end
        $finish;
    end
endmodule