module FFD_reset_async(
    input clk, reset_async, d,
    output reg q
);

    // lógica secuencial
    always @(posedge clk or reset_async)begin
        // si reset_async == 1
        if(reset_async) q<=0;
        else q<=d;
    end
endmodule