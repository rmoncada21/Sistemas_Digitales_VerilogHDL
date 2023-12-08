//Libro Morris Mano pg 105
//UPD: primitivas definadas por el usuario

primitive crctp(x,A,B,C);
    /* en las primitivas las salidas van primero que las entradas */
    output x; 
    input A,B,C;

    //Tabla de verdad para x=(A,B,C)  = sum (0,2,4,6,7)
    // sum: simbolo de sumatoria
    table
        /* A B C : x  */
        0 0 0 : 1;
        0 0 1 : 0;
        0 1 0 : 1;
        0 1 1 : 0;
        1 0 0 : 1;
        1 0 1 : 0;
        1 1 0 : 1;
        1 1 1 : 0;
    endtable 

endprimitive

module declare_crctp;
    reg x,y,z;
    wire w;
    crctp (w,x,y,z); /* Genera un circuito digital */
endmodule

/* Las primitivas generan un circuitos w(x,y,z) = sum (0,2,4,6,7) */