// Circuito con delay(retardo)
// 'timescale 1ns/100ps por decir un ejemplo
module delay(A,B,C,x,y);

    input A,B,C;
    output x,y;
    wire e;

    // el retardo se hace con las directiva 
    // #(tiempo_de_retardo)
    and #(30) g1(e,A,B);
    or  #(20) g3(x,e,y);
    not #(10) g2(y,C);

endmodule