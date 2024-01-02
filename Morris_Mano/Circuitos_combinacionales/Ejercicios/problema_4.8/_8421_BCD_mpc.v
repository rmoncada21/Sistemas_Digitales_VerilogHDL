module con_8421_BCD_mpc(
    input ocho, cuatro, dos, uno,
    /*Recordar que para el bloque 
    always se tiene que usar variables reg
    */

    output reg B, C, D, d
);
    // Modelado por comportamiento
    //8421 BCD 
    // 0000    0000
    // 0111    0001
    // 0110    0010
    // 0101    0011
    // 0100    0100
    // 1011    0101
    // 1010    0110
    // 1001    0111
    // 1000    1000
    // 1111    1001
    always @({ocho, cuatro, dos, uno}) begin
        case({ocho, cuatro, dos, uno})
            4'b0000: {B,C,D,d} = 4'b0000;
            4'b0111: {B,C,D,d} = 4'b0001;
            4'b0110: {B,C,D,d} = 4'b0010;
            4'b0101: {B,C,D,d} = 4'b0011;
            4'b0100: {B,C,D,d} = 4'b0100;
            4'b1011: {B,C,D,d} = 4'b0101;
            4'b1010: {B,C,D,d} = 4'b0110;
            4'b1001: {B,C,D,d} = 4'b0111;
            4'b1000: {B,C,D,d} = 4'b1000;
            4'b1111: {B,C,D,d} = 4'b1001;
            default: $display("MPC");
        endcase
    end
endmodule