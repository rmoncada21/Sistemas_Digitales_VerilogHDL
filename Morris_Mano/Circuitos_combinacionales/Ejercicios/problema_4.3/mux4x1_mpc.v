module mux4x1_mpc(A, B, ES, Y);
    input reg [3:0] A, B;
    input reg [1:0] ES;
    output reg [3:0] Y;

    always @ (A or B or ES)
        case (ES)
            2'b11, 2'b10: Y = 4'b0000;
            2'b00: Y = A;
            2'b01: Y = B;
            default: Y = 4'bxxxx;
        endcase
endmodule

/*
 las salidas (output) son de solo lectura y no pueden ser asignadas 
 dentro de un bloque always. Para corregir esto, puedes cambiar 
 la declaración de Y de output a reg, 
 ya que parece que estás intentando modelar el comportamiento del multiplexor:
*/