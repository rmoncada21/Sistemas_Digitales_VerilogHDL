// | BCD (Entradas)  | a | b | c | d | e | f | g |
// |-----------------|---|---|---|---|---|---|---|
// |       0000      | 1 | 1 | 1 | 1 | 1 | 1 | 0 |  7'b1111110
// |       0001      | 0 | 1 | 1 | 0 | 0 | 0 | 0 |  7'b0110000
// |       0010      | 1 | 1 | 0 | 1 | 1 | 0 | 1 |  7'b1101101
// |       0011      | 1 | 1 | 1 | 1 | 0 | 0 | 1 |  7'b1111001
// |       0100      | 0 | 1 | 1 | 0 | 0 | 1 | 1 |  7'b0110011
// |       0101      | 1 | 0 | 0 | 1 | 0 | 1 | 1 |  7'b1001011
// |       0110      | 1 | 0 | 0 | 1 | 1 | 1 | 1 |  7'b1001111
// |       0111      | 1 | 1 | 1 | 0 | 0 | 0 | 0 |  7'b1110000
//    
//  
// |       1000      | 1 | 1 | 1 | 1 | 1 | 1 | 1 |  7'b1111111
// |       1001      | 1 | 1 | 1 | 1 | 0 | 1 | 1 |  7'b1111011




module display_7seg(
    input reg [3:0] iBCD,
    output reg [6:0] abcdefg
);
    // Modelado por nivel de compuertas
    wire
        i, B, C, D,
        a, b, c, d, e, f, g,
        Bnot, Cnot, Dnot,
        wxn1, wxn2, 
        wxor1, wxor2,
        wor1, wor2, wor3,
        wand1, wand2, wand3, wand4;
    
    buf
        // Entradas
        // bufi(i, iBCD[3]),
        bufi(i, iBCD[3]),
        bufB(B, iBCD[2]),
        bufC(C, iBCD[1]),
        bufD(D, iBCD[0]),
        // Salidas
        bufa(abcdefg[6], a),
        bufb(abcdefg[5], b),
        bufc(abcdefg[4], c),
        bufd(abcdefg[3], d),
        bufe(abcdefg[2], e),
        buff(abcdefg[1], f),
        bufg(abcdefg[0], g);


    not 
        not1(Bnot, B),
        not2(Cnot, C),
        not3(Dnot, D);

    xnor
        xnor1(wxn1, B, D),
        xnor2(wxn2, C, D);
    

    xor 
        xor1(wxor1, B, C),
        // Son la misma compuerta
        xor2(wxor2, B, C);
    
    or 
        ora(a, wxn1, C),
        orb(b, wxn2, Bnot),
        orc(c, wor3, B),
        ord(d, wxor1, Dnot),
        orf(f, wand2, wand3),
        org(g, wxor2, wand4),
        // otros
        or1(wor1, C, Bnot),
        or2(wor2, Cnot, Dnot),
        or3(wor3, Cnot, wand1);
    
    and
        and1(wand1, C, D),
        // andd(d, wxor1, Dnot),
        ande(e, wor1, Dnot),
        and2(wand2, Cnot, Dnot),
        and3(wand3, wor2, B),
        and4(wand4, C, Dnot);

    initial begin
        $display("Circuito HECHO\n");
    end
endmodule