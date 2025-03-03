`include "reg_1bit_pipo_with_FFD_load_control.v"

module reg_nbits_pipo #(parameter N=4)(
    input carga, reloj,
    input [N-1:0] In,
    output [N-1:0] An
);
    genvar i;
    generate
        for(i=0; i<N; i++) begin : reg_bits
            reg_1bit_pipo_with_FFD_load_control reg_pipo(
                .carga(carga),
                .reloj(reloj),
                .In(In[i]),
                .An(An[i])
            );
        end
    endgenerate

endmodule