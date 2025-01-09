module ffd_edge_trigered(
    output q, qbar,
    input d, clk, clear
);
    // cableado interno
    wire s, sbar, r, rbar, cbar;

    // flujo de datos
    assign cbar=~clear;

    // Input latches
    assign  sbar=~(rbar & s),
            s=~(sbar&cbar&~clk),
            r=~(rbar&clk&s),
            rbar=~(r&cbar&d);
    
    assign  q=~(s&qbar),
            qbar=~(q&r&cbar);

endmodule