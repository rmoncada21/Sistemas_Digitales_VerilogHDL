// Ejemplo 6.1 

/*  Descripción del comportamiento de un 
    registro de desplazamiento universal
    figura 6-7 y tabla 6-3 
*/

module register_universal_shift(
    output reg [3:0] An,
    input clk, clear, S1, S0, shift_left, shift_right,
    input [3:0] Parallel_In
);

    // Descripción del registro universal
    always @ (posedge clk or negedge clear) begin
        if (~clear) An = 4'b0000;
        else 
            // S1 msb - S0 LSB
            case({S1, S0})
            2'b00: An <= An;
            2'b01: An <= {shift_right, An[3:1]};
            2'b10: An <= {An[2:0], shift_left};
            2'b11: An <= Parallel_In;
            endcase  
    end

endmodule 