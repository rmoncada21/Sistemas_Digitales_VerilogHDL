`include "ffd_edge_trigered.v"

module tff_edge_trigered(
    output q,
    input clk, clear
);

    // Instanciación de ffd edge trigered
    ffd_edge_trigered ff1(q, ,~q, clk, clear);

endmodule