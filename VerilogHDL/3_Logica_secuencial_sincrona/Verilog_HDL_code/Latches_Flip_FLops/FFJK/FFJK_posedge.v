module FFJK_posedge(
    output reg Q, Qnot,
    input J, K, clk, reset_async
);
    assign Qnot = ~Q;

    always @ (posedge clk or negedge reset_async) begin
        if (~reset_async) begin
            Q <= 0;
        end else begin
            case({J,K})
            2'b00: Q <= Q;
            2'b01: Q <= 1'b0; 
            2'b10: Q <= 1'b1;
            2'b11: Q <= ~Q;
            endcase    
        end
    end
endmodule