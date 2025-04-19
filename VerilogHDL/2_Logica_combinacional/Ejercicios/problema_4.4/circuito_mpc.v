module circuito_less3b_mpc(ABC, F);
    input reg [2:0] ABC;
    output reg F;

    always @(ABC) begin
        case (ABC)
            3'b000, 3'b001, 3'b010: F = 1'b1;
            default: F = 1'b0;
        endcase
    end
endmodule

/*
 las salidas (output) son de solo lectura y no pueden ser asignadas 
 dentro de un bloque always. Para corregir esto, puedes cambiar 
 la declaración de Y de output a reg, 
 ya que parece que estás intentando modelar el comportamiento del multiplexor:
*/