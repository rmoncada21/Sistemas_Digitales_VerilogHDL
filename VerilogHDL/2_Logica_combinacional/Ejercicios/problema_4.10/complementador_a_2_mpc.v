module complementador_a_2_mpc(
    input reg [3:0] ABCD,
    output reg [3:0] wxyz
);

    // Modelado por comportamiento
    always@(ABCD) begin
        wxyz = ~ABCD+ 4'b0001;
    end
endmodule