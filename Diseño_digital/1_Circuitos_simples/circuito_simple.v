// module 
module circuito_simple(A,B,C,x,y);
    // Puertos: salidas y entradas del circuito
    input A,B,C;
    output x,y;
    // conexion interna o cable
    wire e;
    
    // se ponen primero las salidas, despues las entradas
    and g1(e,A,B);
    not g2(y,C);
    or g3(x,e,y);

endmodule