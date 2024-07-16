// Archivo: sumador4bits.v
`timescale 1ns/1ps 

module sumador(
    input [3:0] a, 
    input [3:0] b, 
    output [4:0] sum
    );
    
    assign sum = a + b;
endmodule

