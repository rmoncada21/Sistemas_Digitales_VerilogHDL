`include "tff_edge_trigerred.v"

module ripple_counter(
    output [3:0] Q,
    input clock, clear
);
    // Instanciación de los flips flops
    tff_edge_trigered tFF1(Q[0], clock, clear);
    tff_edge_trigered tFF2(Q[1], Q[0], clear);
    tff_edge_trigered tFF3(Q[2], Q[1], clear);
    tff_edge_trigered tFF4(Q[3], Q[2], clear);

endmodule