module mayoria_mpc(
    input reg [2:0] ABC,
    output reg F
);
    // contaddores de unos y ceros 
    reg [1:0] unos, ceros;

    always @ (ABC) begin
        unos=0;
        ceros=0;
            
        for (int i=0; i<=2; i++) begin
            if(ABC[i]==1)
                unos++;
            else 
                ceros++;
        end

        if(unos>ceros)
            F=1;
        else 
            F=0;
    end
endmodule