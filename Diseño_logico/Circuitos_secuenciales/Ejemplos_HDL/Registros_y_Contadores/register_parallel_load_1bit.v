`include "FFD_reset_async.v"

module register_parallel_load_1bit(
    output reg Q,
    input clk, carga, In, reset_async
);
    // Salida del modulo 
    // assign D = (carga & In) | (Q & ~carga);  
    // assign D = carga ? In:Q;

    reg get_data;

    FFD_reset_async 
        FFD(Q, clk, ((carga*In)+(Q*(!carga))), reset_async);
        // FFD(get_data, clk, ((carga&In)|(Q&~carga)), reset_async);

    // assign Q=get_data;
endmodule