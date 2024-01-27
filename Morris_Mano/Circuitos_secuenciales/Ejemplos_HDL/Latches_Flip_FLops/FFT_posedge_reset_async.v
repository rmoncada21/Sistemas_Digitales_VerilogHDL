module FFT_posedge_reset_async(
    output reg Q, 
    input clk, T, reset_async
);
    always @ (posedge clk or negedge reset_async) begin
        if(~reset_async) begin
            Q <= 1'b0;
        end else begin
            case(T)
            1'b0: Q <= Q;
            1'b1: Q <= ~Q;
            default: $display("Valor default x") ;
            endcase
        end  
    end
endmodule

//Con reset = 1

//   T | Q(t+1)
//-----|----------
//   0 |  Q(t)
//   1 | ~Q(t)