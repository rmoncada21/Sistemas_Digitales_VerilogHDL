// Sumador completo modelado a nivel de compuertas 
module sumador_completo(
    output Acarreo, Suma,
    input x_, y_, z_
);
    wire
        wand1, wand2, wxor1;
    // Modelado del sumador
    xor
        xor1(wxor1, x_, y_),
        xorS(Suma, wxor1, z_);
    
    and 
        and1(wand1, wxor1, z_),
        and2(wand2, x_, y_);
    
    or
        orA(Acarreo, wand1, wand2);
endmodule