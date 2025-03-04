module FFD(C, D, Q);
    input C, D;
    output Q;

    reg Q;

    // Lógica secuencial
    always @(posedge C) begin
        Q <= D;
    end
endmodule