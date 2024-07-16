module multiplicador_1bit(
    output reg [3:0] F,
    input reg [3:0] In,
    input select
);

    // Modelado por nivel de compuertas
    and
        and3(F[3], select, In[3]),
        and2(F[2], select, In[2]),
        and1(F[1], select, In[1]),
        and0(F[0], select, In[0]);

endmodule