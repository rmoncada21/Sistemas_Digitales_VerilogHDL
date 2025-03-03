// `include "FFD.v"

// código para controlar la carga o no carga de los FFD
module load_control(
    input carga, In, An,
    output data_control
);

    assign data_control = In & carga | ~carga & An;



endmodule