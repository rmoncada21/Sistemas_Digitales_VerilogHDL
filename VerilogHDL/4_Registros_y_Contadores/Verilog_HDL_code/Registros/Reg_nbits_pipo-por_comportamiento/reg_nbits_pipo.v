module reg_nbits_paralell_load #(parameter N=4)(
    input reloj, carga,
    input [N-1:0] In,
    output reg [N-1:0] An
);

    always @(posedge reloj or negedge reset_despeje) begin
        // resgitro con carga activa en 1
        if(carga) An<=In;
        else An<=An;
    end

endmodule