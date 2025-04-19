module FFD_reset_async(
    input clk, reset_async, d,
    output reg q
);

    // lógica secuencial
    // Flip flop con reset activo en alto 1 
    always @(posedge clk or posedge reset_async)begin
        // borra memoria cuando reset = 1
        if(reset_async) q<=0;
        else q<=d;
    end
endmodule