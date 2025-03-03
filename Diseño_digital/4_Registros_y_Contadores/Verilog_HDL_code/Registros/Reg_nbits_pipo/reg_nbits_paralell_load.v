module reg_nbits_paralell_load #(parameter N=4)(
    input reloj, reset_despeje, // usando reset async = 1
    input [N-1:0] In, 
    output reg [N-1:0] An
);

    // lógica de registro (basicamente de un FFD)
    always @(posedge reloj or negedge reset_despeje) begin
        // reset activo en bajo 0
        // si reset = 0; borra memoria
        if(!reset_despeje) An<=0;
        else An<=In;
    end

endmodule