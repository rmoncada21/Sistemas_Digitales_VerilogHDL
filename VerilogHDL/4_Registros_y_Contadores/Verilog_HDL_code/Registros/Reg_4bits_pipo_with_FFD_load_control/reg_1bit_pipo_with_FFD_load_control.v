`include "FFD.v"
`include "load_control.v"

module reg_1bit_pipo_with_FFD_load_control(
    input carga, reloj,
    input In,
    output An
);

    // Instanciar FFD y load control
    wire intern_data;

    FFD ffd(.reloj(reloj), .D(intern_data), .An(An));
    load_control control(.carga(carga), .In(In), .An(An), .data_control(intern_data));

endmodule