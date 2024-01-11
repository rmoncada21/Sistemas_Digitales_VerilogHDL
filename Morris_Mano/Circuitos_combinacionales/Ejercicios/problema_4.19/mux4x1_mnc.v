module mux4x1_mnc(
    // Entradas y salidas del modulo
    output reg [3:0] F,
    input reg Select,
    input reg [3:0] I0, I1
);
    wire 
        notSelect,
        wand1, wand2, wand3, wand4, wand5, wand6, wand7, wand8,
        I03, I02, I01, I00, I13, I12, I11, I10;
    // Modelado por nivl de compuertas
    not 
        notSel(notSelect, Select);
    
    buf
        b1(I03, I0[3]), b2(I02, I0[2]), b3(I01, I0[1]), b4(I00, I0[0]), 
        b5(I13, I1[3]), b6(I12, I1[2]), b7(I11, I1[1]), b8(I10, I1[0]);
    
    and
        and1(wand1, I03, notSelect), and3(wand3, I02, notSelect), and5(wand5, I01, notSelect), and7(wand7, I00, notSelect),
        and2(wand2, I13, Select),  and4(wand4, I12, Select),  and6(wand6, I11, Select),  and8(wand8, I10, Select);
    
    or
        or1(F[3], wand1, wand2), or2(F[2], wand3, wand4), or3(F[1], wand5, wand6), or4(F[0], wand7, wand8);
    
endmodule