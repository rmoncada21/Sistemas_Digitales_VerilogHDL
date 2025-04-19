module circuito_mpc(
    input reg [2:0] XYZ,
    output reg [2:0] ABC
);

    // Modelado por comportamiento
    always @ (XYZ)
        if (XYZ[2]==0) begin
            ABC = XYZ + 1;
        end else if(XYZ[2]==1) begin
            ABC = XYZ - 1;
        end
endmodule