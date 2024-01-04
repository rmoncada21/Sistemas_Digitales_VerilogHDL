module display_numero_ocho(
    input wire clk,  // Puedes usar un reloj para parpadear el display
    output wire a, b, c, d, e, f, g
);
    reg [3:0] contador;

    always @(posedge clk) begin
        // Contador para simular el cambio en el número
        contador <= contador + 1;
    end

    assign a = (contador == 4'b0000) | (contador == 4'b1111) | (contador == 4'b1110) | (contador == 4'b0001);
    assign b = (contador == 4'b1110) | (contador == 4'b1100) | (contador == 4'b1011);
    assign c = (contador == 4'b0000) | (contador == 4'b1111) | (contador == 4'b1110) | (contador == 4'b0001);
    assign d = (contador == 4'b1110) | (contador == 4'b1100) | (contador == 4'b1011);
    assign e = (contador == 4'b1110) | (contador == 4'b0001) | (contador == 4'b0000);
    assign f = (contador == 4'b1100) | (contador == 4'b1011);
    assign g = (contador == 4'b1110) | (contador == 4'b0001) | (contador == 4'b0000);
endmodule
