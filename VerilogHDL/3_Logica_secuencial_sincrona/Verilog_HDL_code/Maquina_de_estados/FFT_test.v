module Tcircuit (x,y,A,B,CLK,RST);
    input x,CLK,RST;
    output y,A,B;
    wire TA,TB;
    
    //Ecuaciones de entrada de flip-flop
    assign TB = x, TA = x & B;
    //Ecuación de salida
    assign y = A & B;
    //Se crean ejemplares de flip-flops T
    T_FF BF (B,TB,CLK,RST);
    T_FF AF (A,TA,CLK,RST);
endmodule


//Flip-flop T
module T_FF (Q,T,CLK,RST);
    output Q;
    input T,CLK,RST;
    reg Q;
    always @ (posedge CLK or negedge RST)
        if (~RST) Q = 1'b0;
    else Q = Q ^ T;
endmodule