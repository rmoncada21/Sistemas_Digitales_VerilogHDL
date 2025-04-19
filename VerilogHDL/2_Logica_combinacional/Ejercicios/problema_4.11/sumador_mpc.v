module sumador_mpc(
    input reg [3:0] ABCD,
    output reg [4:0] Suma
);

    // Modelado por comportamiento 
    always@(ABCD) begin
        Suma = ABCD + 4'b0001;
    end
endmodule