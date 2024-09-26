module contador #(parameter WIDTH = 8)(
    input wire clk,
    input wire rst,
    output reg [WIDTH-1:0] cuenta
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            cuenta <= 0;
        else
            cuenta <= cuenta + 1;
    end
endmodule

module test_contador;
    reg clk;
    reg rst;
    wire [15:0] count1;
    wire [7:0] count2;

    // Instanciamos el contador con WIDTH sobrescrito usando parámetros asociativos
    contador #(.WIDTH(16)) contador_inst1 (
        .clk(clk),
        .rst(rst),
        .cuenta(count1)
    );

    // Instancia del contador con el parámetro WIDTH por defecto (8 bits)
    contador contador_inst2 (
        .clk(clk),
        .rst(rst),
        .cuenta(count2)
    );

    // Generación del clock y reset en el testbench
    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;  // Desactivamos el reset después de 10 unidades de tiempo
    end

    always #5 clk = ~clk;  // Generador de reloj con un periodo de 10 unidades de tiempo
endmodule
