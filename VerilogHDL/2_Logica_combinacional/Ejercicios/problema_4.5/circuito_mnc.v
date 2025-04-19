module circuito_mnc(xyz, ABC);
    // Entradas y salidas del circuito
    input reg [2:0] xyz;
    output reg [2:0] ABC;
    wire wa, wb, wc, wd, we, xnot, ynot, znot, wire_andch, wire_andch2, wire_andch3, wire_orch;

    // Modelado por nivel de compuertas
    not 
        (xnot, xyz[2]),
        (ynot, xyz[1]),
        (znot, xyz[0]);
    and
        and1 (wa, xyz[1], xyz[0]),
        and2 (wb, xyz[2], wc),
        and3 (wd, xnot, we),
        andch (wire_andch, xyz[2], wire_orch),
        andch2 (wire_andch2, ynot, znot),
        andch3 (wire_andch3, xyz[1], xyz[0] );
    or
        or1 (wc, xyz[1], xyz[0]),
        or2 (ABC[1], wire_andch, wd),
        or3 (ABC[2], wa, wb),
        orch (wire_orch, wire_andch2, wire_andch3);
    xor
        xor1 (we, xyz[1], xyz[0]);
    
    buf 
        b1(ABC[0], znot);
endmodule 

// Este circui
// 110
// 101