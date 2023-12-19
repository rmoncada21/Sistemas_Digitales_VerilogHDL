// Descripci+on de flujo de datos del mulitplexor 2 a 1

module multiplexor2x1(A, B, select, OUT);
    input A, B, select;
    output OUT;
    
    assign OUT = select ? A:B;

endmodule