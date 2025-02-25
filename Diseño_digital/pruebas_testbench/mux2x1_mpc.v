// Modelado por comportamiento
module mux2x1_mpc(i0, i1, select, y);
    input i0, i1, select;
    output reg y;

    always @ (i0 or i1 or select)
        if (select) y = i1;
        else y = i0;
endmodule

/*
 las salidas (output) son de solo lectura y no pueden ser asignadas 
 dentro de un bloque always. Para corregir esto, puedes cambiar 
 la declaración de Y de output a reg, 
 ya que parece que estás intentando modelar el comportamiento del multiplexor:
*/