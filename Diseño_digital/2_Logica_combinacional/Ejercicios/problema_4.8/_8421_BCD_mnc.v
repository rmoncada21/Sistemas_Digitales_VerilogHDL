// Decimal | Binary |   BCD   |  8-4-2-1 |
// --------|--------|---------|----------|
//  0      |  0000  | 0000    |  0000    |
//  1      |  0001  | 0001    |  0111    |
//  2      |  0010  | 0010    |  0110    |
//  3      |  0011  | 0011    |  0101    |
//  4      |  0100  | 0100    |  0100    |
//  5      |  0101  | 0101    |  1011    |
//  6      |  0110  | 0110    |  1010    |
//  7      |  0111  | 0111    |  1001    |
//  8      |  1000  | 1000    |  1000    |
//  9      |  1001  | 1001    |  1111    |

// {w, x, y, z} = 4'b0000;

module con_8421_BCD(
    input ocho, cuatro, dos, uno,
    output B, C, D, d
);
    wire
        wa1, wa2, wa3, wa4, wa5,
        wor1, wor2,
        wxor1, wxor2,
        not8, not4, not2, not1;

    // Nivel de compuertas
    not 
        n1(not8, ocho),
        n2(not4, cuatro),
        n3(not2, dos),
        n4(not1, uno);
    
    and
        a1 (wa1, cuatro, dos, uno),
        a2 (wa2, not4, not2, not1),
        a3 (wa3, wor2, wa4),
        a4 (wa4, ocho, not4),
        // a5 (wa5, not8, cuatro, dos, uno),
        a5 (wa5, not8, cuatro, not2, not1),
        // deberia ser una compuerta andB en el diagrama
        aB (B, ocho, wor1),
        aD (D, wxor1, wxor2);
    or
        or1 (wor1, wa1, wa2),
        or2 (wor2, dos, uno),
        orC (C, wa3, wa5);
    xor
        xor1 (wxor1, dos, uno),
        xor2 (wxor2, ocho, cuatro);
    
    buf
        bufd (d, uno);

    initial begin
        $display("Conversor done ");
    end
endmodule

// always @({B, C, D, d}) begin
        
//     end