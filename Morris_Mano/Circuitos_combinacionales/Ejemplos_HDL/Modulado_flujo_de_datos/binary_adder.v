//  Descripcion de flujo de datos de un sumador de 4 bits

module binary_adder (A, B, Cin, SUM, Cout);
    input [3:0] A, B;
    input Cin;
    output [3:0] SUM;
    output Cout;
    //  Representa {Cout, SUM} la concatenación 
    //  de cinco bits de la operacion de suma
    assign {Cout, SUM} = A + B + Cin;
endmodule