module testbench_circuito_mfd;
    reg [3:0] in;
    wire F1, F2;

    // Array para almacenar los valores leídos desde el archivo
    reg [1:0] valores_F1F2 [15:0];

    // Leemos los valores desde el archivo al array
    initial begin
        $readmemh("test.txt", valores_F1F2);
    end

    // instanciación de circuito_mfd 
    circuito_mfd uut(
        .A(in[3]),
        .B(in[2]),
        .C(in[1]),
        .D(in[0]),
        .F1(F1),
        .F2(F2)
    );

    initial begin
        $display("\nTESTBENCH de circuito_mfd.v");
        in = 4'b0000;
        repeat(16) begin
            #10; // Añade una espera de simulación
            in = in + 1'b1;
            // Mostramos los valores leídos desde el archivo
            $display("valores_F1F2[%0d] = 2'b%b", in, valores_F1F2[in]);
        end
    end

    initial begin
        $display("ABCD  F1  F2");
        $monitor("%b  %b    %b", in, F1, F2);
    end
endmodule



// module testbench_circuito_mfd;
//     reg [3:0] in;
//     wire F1, F2;

//     // instanciación de circuito_mfd 
//     circuito_mfd uut(
//         .A(in[3]),
//         .B(in[2]),
//         .C(in[1]),
//         .D(in[0]),
//         .F1(F1),
//         .F2(F2)
//     );


//     initial begin
//         $display("\nTESTBENCH de circuito_mfd.v");
//         in = 4'b0000;
//         repeat(16) begin
//             #10
//             in = in + 1'b1;
//         end

//     end

//     initial begin
//         $display("ABCD  F1  F2");
//         $monitor("%b  %b    %b", in, F1, F2);
//     end
// endmodule