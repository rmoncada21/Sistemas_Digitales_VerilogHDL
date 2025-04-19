// Circuito que identifica cuando la salida es menor a 3 binario
// modelado por flujo de datos
module circuito_less3b(ABC, F);
    input reg [2:0] ABC;
    output F;

    assign F = (( ~ABC[2] & ~ABC[1]) |  ~ABC[2] & ~ABC[0]);
endmodule 