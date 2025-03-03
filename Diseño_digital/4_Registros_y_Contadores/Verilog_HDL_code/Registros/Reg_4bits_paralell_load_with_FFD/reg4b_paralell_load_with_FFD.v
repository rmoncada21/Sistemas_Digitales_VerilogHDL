`include "FFD_reset_async.v"

module reg4b_paralell_load_with_FFD(
    input reloj, despeje_reset,
    input [3:0] In,
    output [3:0] An
);

    // Instanciación de 4's - FFD
    FFD_reset_async 
        ffd0(.clk(reloj), .reset_async(despeje_reset), .d(In[0]), .q(An[0])), 
        ffd1(.clk(reloj), .reset_async(despeje_reset), .d(In[1]), .q(An[1])), 
        ffd2(.clk(reloj), .reset_async(despeje_reset), .d(In[2]), .q(An[2])), 
        ffd3(.clk(reloj), .reset_async(despeje_reset), .d(In[3]), .q(An[3]));

endmodule