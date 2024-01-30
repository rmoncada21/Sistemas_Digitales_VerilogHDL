module FFD_reset_async(
    output reg q, 
    input clk, data, reset_async
);

    // Lógica de FFD por comportamiento
    always @(posedge clk or negedge reset_async) begin
        if (reset_async) q <= data;
        else  q <= 1'b0;
    end
endmodule