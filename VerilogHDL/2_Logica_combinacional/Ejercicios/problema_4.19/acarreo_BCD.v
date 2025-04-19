module acarreo_BCD(
    output Acarreo_BCD,
    input S3, S2, S1, Acout_sumador
);

    // Modelado nivel de compuertas
    wire 
        wA1, wA2;
    
    and
        and1(wA1, S3, S2),
        and2(wA2, S3, S1);
    
    or
        orAcarreo(Acarreo_BCD, Acout_sumador, wA1, wA2);

endmodule