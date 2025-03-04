`include "FFD.v"
module shit_reg_4bits_siso(CLK, SI, SO);
    input CLK, SI;
    output SO;

    wire [2:0] Wire;
    // Instanciar FFD
    FFD 
        ffd0(.C(CLK), .D(SI), .Q(Wire[0])),
        ffd1(.C(CLK), .D(Wire[0]), .Q(Wire[1])),
        ffd2(.C(CLK), .D(Wire[1]), .Q(Wire[2])),
        ffd3(.C(CLK), .D(Wire[2]), .Q(SO));
endmodule 